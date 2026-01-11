function fish_prompt
	set_color brblue
	echo -n (prompt_pwd)
	
	set git_branch (command git symbolic-ref --short HEAD 2>/dev/null)
	if test -n "$git_branch"
		set_color brmagenta
		echo -n "[$git_branch]"
	end
	set_color normal
	echo -n ' > '
end
