#Include WatchFolder.ahk
#include json2.ahk
#SingleInstance, force

#Persistent

Menu, Tray, NoStandard
Menu, Tray, add, 关闭
Menu, Tray, add, 重新载入

global conf := json2("./notify_conf.json")
global to_watch_dirs := conf.watch_dir
global to_watch_files := conf.watch_file

watching := "|"
for i, dir in to_watch_dirs
{
	if fileexist(dir)
	{
		watchfolder(dir, "notifier",True)
		watching := watching . dir . "|"
	}
}
trayTip, Watching, %watching%
return

match_rule(changed,rule){
	Static Actions := {"c":1, "d":2, "m":3, "r":4}
	if (IsObject(rule)){
		re := rule.re
		action := Actions[rule.action]
		if (RegExMatch(changed.Name, re) && action == changed.Action){
			return True
		}else{
			return False
		}
	}else{
		re := rule
		if (RegExMatch(changed.Name, re)){
			return True
		}else{
			return False
		}
	}

}



notifier(Folder, Changes) {
	Static Actions := ["新增", "删除", "更改", "重命名"]
	For Each, Change In Changes
	{
		for idx, file_name in to_watch_files
		{
			if (match_rule(Change, file_name)){
				alert :=Actions[Change.Action] " : " . Change.Name
				trayTip, 最近更新, %alert%
				break
			}
		}

	}
	return
}


关闭:
	ExitApp
	return

重新载入:
	reload
	return	