#ifndef __FILEUNIT_HEAD__
#define __FILEUNIT_HEAD__

#include "cocos2d.h"
#include <string>
#include <vector>
#include <stack>
#include "fileeditsys.h"
#include "sqlite3.h"
USING_NS_CC;
class celldef : public Ref
{
public:
	static celldef* create() {
		celldef* c = new celldef();
		c->autorelease();
		return c;
	}
public:
	std::string m_path;
	std::string m_title;
	std::string m_content;

	std::string getpath() {return m_path;}
	std::string gettitle() {return m_title;}
	std::string getcontent() {return m_content;}
	void setpath(std::string l) {m_path = l;}
	void settitle(std::string l) {m_title = l;}
	void setcontent(std::string l) {m_content = l;}
};
class FileUnit : public Ref//index->dir->bookname->bookchapter->bookcontent
{
public:
	static FileUnit* create(std::string filename);
private:
	FileUnit(std::string filename);
public:
	~FileUnit();
public:
	/////
	//Vector<celldef*>& getcelllist();
	void runcommand(std::string cmd);
	bool createdir(std::string dirname);
	bool createfile(std::string filename, std::string filecontent, string flag);
	bool opendir(std::string dirname);
	bool openfile(std::string filename);
	std::string getcurfile();
	bool gotoupdir();
	void gotorootdir();
	Vector<celldef*>& getfilelist();
	std::vector<std::string>& getfullpath();
private:
	bool createfile1(std::string filename, std::string filecontent, string flag);
	bool openpath(std::string filename);
public:
	Vector<celldef*>& getbooklist();
	bool createnewbook(std::string name, std::string url);//url == key
	bool openbook(std::string name, std::string url);
	Vector<celldef*>& getbooktitlelist();
	bool addbooktitle(std::string name, std::string url);//url == key
	bool openbooktitle(std::string name, std::string url);
	bool addbooktitlecontent(std::string title, std::string content, std::string url);
	bool openbooktitlecontent(std::string name, std::string url);
	std::string getbooktitlecontent();
	bool onpageback();
	std::string getmybookname();
private:
	std::string m_filename;
	fileeditsys* m_pfileeditsys;
	std::vector<std::string> m_curpath;
	//union
	//{
	//	struct
	//	{
	//		char a;
	//		char b;
	//		char c;
	//		char d;
	//	};
	//	unsigned long len;
	//	long length;
	//} unionlen;
	Vector<celldef*> m_celllist;
	sqlite3* m_psqlite3;
};


class pingpong
{
public:
	pingpong(){};
	~pingpong(){};
	void destroy(){delete this;}
};
#endif