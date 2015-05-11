#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use Net::Curl::Easy qw(:constants);
use JSON::XS;
use Getopt::Long;

my $easy = Net::Curl::Easy->new();

my $httpheaders=[
	"Accept:application/json;charset=UTF-8",
	"Content-Type:application/json",
];
$easy->setopt(CURLOPT_HTTPHEADER,$httpheaders);
my $url="http://127.0.0.1:7474/db/data/transaction";
my $json=qq/
{
  "statements" : [ {
    "statement" : "CREATE (n {props}) RETURN n",
    "parameters" : {
      "props" : {
        "name" : "My Node"
      }
    }
  } ]
}/;

$easy->setopt(CURLOPT_POSTFIELDS,$json);
$easy->setopt(CURLOPT_POSTFIELDSIZE,length($json));
$easy->setopt(CURLOPT_URL,$url);
my $response;
my $error;
$easy->setopt(CURLOPT_WRITEDATA,\$response);
#$easy->setopt(CURLOPT_ERRORBUFFER,\$error);
$easy->perform();
my $JSON_codec=JSON::XS->new->utf8;
my $json_response=$JSON_codec->decode($response);
print Dumper($json_response)."\n";
