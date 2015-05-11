package Neo4jContext; 
use strict;
use Exporter;
use Net::Curl::Easy qw(:constants);
use JSON::XS;
use Carp qw(confess carp croak cluck);
our @ISA=qw(Exporter);
our @EXPORT=qw(new ask);
sub new{
	my $obj={
		CURL=>Net::Curl::Easy->new(),
		JSON_CODEC=>JSON::XS->new->utf8,
	};
	my $httpheaders=[
		"Accept:application/json;charset=UTF-8",
		"Content-Type:application/json",
	];
	$obj->{CURL}->setopt(CURLOPT_HTTPHEADER,$httpheaders);
	bless $obj,'Neo4jContext';
	return $obj;
}

sub ask{
	my ($obj,$url_ref,$json_ref)=@_;
	$obj->{CURL}->setopt(CURLOPT_URL,$$url_ref);
	$obj->{CURL}->setopt(CURLOPT_POSTFIELDS,$$json_ref);
	$obj->{CURL}->setopt(CURLOPT_POSTFIELDSIZE,length($$json_ref));
	my $response;
	$obj->{CURL}->setopt(CURLOPT_WRITEDATA,\$response);
	$obj->{CURL}->perform();
	my $status=$obj->{CURL}->getinfo(CURLINFO_RESPONSE_CODE);
	confess "http response code:$status" if not ($status >= 200 && $status < 300);
	return $obj->{JSON_CODEC}->decode($response);
}
