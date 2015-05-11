#include<iostream>
#include<cstdio>
#include<string>
#include "curl/curl.h"
#pragma comment(lib, "libcurl.lib")
using namespace std;
long writer(void *data, int size, int nmemb, string &content);
bool  CurlInit(CURL *&curl, const char* url,string &content);
bool  GetURLDataBycurl(const char* URL, string &content);

int main()
{
    const char *url ="http://www.baidu.com/img/baidu.gif";
    string content;
    if ( GetURLDataBycurl(url,content))
    {
        printf("%s\n",content.c_str());

    }
    getchar();
}

bool CurlInit(CURL *&curl, const char* url,string &content)
{
    CURLcode code;
    char  errbuf[4096];
    curl = curl_easy_init();
    if (curl == NULL)
    {
        printf( "Failed to create CURL connection\n");
        return false;
    }
    code = curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, errbuf);
    if (code != CURLE_OK)
    {
        printf( "Failed to set errbuf buffer [%d]\n", code );
        return false;
    }
    curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
    code = curl_easy_setopt(curl, CURLOPT_URL, url);
    if (code != CURLE_OK)
    {
        printf("Failed to set URL [%s]\n", errbuf);
        return false;
    }
    code = curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1);
    if (code != CURLE_OK)
    {
        printf( "Failed to set redirect option [%s]\n", errbuf );
        return false;
    }
    code = curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writer);
    if (code != CURLE_OK)
    {
        printf( "Failed to set writer [%s]\n", errbuf);
        return false;
    }
    code = curl_easy_setopt(curl, CURLOPT_WRITEDATA, &content);
    if (code != CURLE_OK)
    {
        printf( "Failed to set write data [%s]\n", errbuf );
        return false;
    }
    return true;
}

long writer(void *data, int size, int nmemb, string &content)
{
    long sizes = size * nmemb;
	//string temp(data,sizes);
    //content += temp; 
	char* begin=(char*)data;
	char* end=begin+sizes;
	string t(sizes,0);
	std::copy(begin,end,t.begin());
	content+=t;
    return sizes;
}

bool GetURLDataBycurl(const char* URL,  string &content)
{
    CURL *curl = NULL;
    CURLcode code;
    char errbuf[4096];

    code = curl_global_init(CURL_GLOBAL_DEFAULT);
    if (code != CURLE_OK)
    {
        printf( "Failed to global init default [%d]\n", code );
        return false;
    } 
    
    if ( !CurlInit(curl,URL,content) )
    {
        printf( "Failed to global init default [%d]\n" );
        return false;
    }
    code = curl_easy_perform(curl);
    if (code != CURLE_OK)
    {
        printf( "Failed to get '%s' [%s]\n", URL, errbuf);
        return false;
    }
    long retcode = 0;
    code = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE , &retcode); 
    if ( (code == CURLE_OK) && retcode == 200 )
    {
        double length = 0;
        code = curl_easy_getinfo(curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD , &length); 
        printf("%d",retcode);
        FILE * file = fopen("1.gif","wb");
        fseek(file,0,SEEK_SET);
        fwrite(content.c_str(),1,length,file);
        fclose(file);

        //struct curl_slist *list;
        //code = curl_easy_getinfo(curl,CURLINFO_COOKIELIST,&list);
        //curl_slist_free_all (list);

        return true;
    }
    else
    {
    //    debug1( "%s \n ",getStatusCode(retcode));
        return false;
    }
    curl_easy_cleanup(curl);
    return false;
}
