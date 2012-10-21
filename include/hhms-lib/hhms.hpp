#ifndef _TABLE_HPP
#define _TABLE_HPP

#include <vector>
#include <map>

class Assignment {
private:
    std::string name, assignDate, dueDate, description;
public:
    Assignment(std::string, std::string, std::string, std::string);

    std::string get_name();
    std::string get_assigned_date();
    std::string get_due_date();
    std::string get_description();
};

class ClassTable {
private:
    // int = period number, vector = assignments
    std::map<std::pair<int, std::string>, std::vector<Assignment> > table;
public:
    void add_assignment(int period, Assignment assignment) throw(std::string);
    void add_class(int period, std::string name);
    std::pair<const std::pair<int, std::string>, std::vector<Assignment> > *find_class(int period) throw(std::string);
    Assignment get_assignment(int period, std::string name) throw(std::string);
};

int download_file(const char *url, const char *output);

#endif
