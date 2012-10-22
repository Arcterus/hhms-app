#include <iostream>
#include <fstream>
#include <string.h>
#include <curl/curl.h>
#include <sys/stat.h>
#include "pugixml/pugixml.hpp"
#include <hhms.hpp>
#include <config.hpp>

using namespace std;

Assignment::Assignment(string name, string assignDate, string dueDate, string description) {
    this->name = name;
    this->assignDate = assignDate;
    this->dueDate = dueDate;
    this->description = description;
}

string Assignment::get_name() {
        return name;
}

string Assignment::get_assigned_date() {
    return assignDate;
}

string Assignment::get_due_date() {
    return dueDate;
}

string Assignment::get_description() {
    return description;
}

void ClassTable::add_assignment(int period, Assignment assignment) throw(string) {
    find_class(period)->second.push_back(assignment);
}

void ClassTable::add_class(int period, string name) {
    table.insert(make_pair(make_pair(period, name), vector<Assignment>()));
}

pair<const pair<int, string>, vector<Assignment> > *ClassTable::find_class(int period) throw(string) {
    map<pair<int, string>, vector<Assignment> >::iterator iter;
    for(iter = table.begin(); iter != table.end(); iter++) {
        if(iter->first.first == period) {
            return &(*iter);
        }
    }
    throw period + " not found!";
}

Assignment ClassTable::get_assignment(int period, string name) throw(string) {
    vector<Assignment> work = find_class(period)->second;
    vector<Assignment>::iterator iter;
    for(iter = work.begin(); iter != work.end(); iter++) {
        if(iter->get_name() == name) {
            return *iter;
        }
    }
    throw name + " not found!";
}

int ClassTable::download_file(const char *url, const char *outputname) {
    CURLcode res = (CURLcode) 0;
    CURL *curl = curl_easy_init();
    if(curl) {
        const char *tempname = (outputname + string(".temp")).c_str();
        FILE *output = fopen(tempname, "w");
        if(output == NULL) {
            fprintf(stderr, "Error: Could not create file (%s)\n", tempname);
            fputs("Could not create file (data.xml)", stderr);
            curl_easy_cleanup(curl);
            return 1;
        }
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, output);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
        res = curl_easy_perform(curl);
        fclose(output);
        if(res) {
            fputs(curl_easy_strerror(res), stderr);
        } else {
            if(rename(tempname, outputname)) {
                perror(NULL);
                return 1;
            }
        }
        curl_easy_cleanup(curl);
    }
    return (int) res;
}

bool ClassTable::load_data(string studentID) {
    struct stat stat_info;
    if(stat(
#ifdef IOS
            "Documents/"
#endif
            "data.xml", &stat_info)) {

    }
    return true;
}
