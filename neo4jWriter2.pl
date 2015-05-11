#!/usr/bin/perl -w
use strict;
use Neo4jContext;
use Data::Dumper;

my $neo4jctx=Neo4jContext->new();
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
my $result=$neo4jctx->ask(\$url,\$json);
print Dumper($result)."\n";
