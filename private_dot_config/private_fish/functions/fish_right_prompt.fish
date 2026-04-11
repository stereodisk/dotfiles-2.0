function fish_right_prompt
    set -l right_info ""

    set -l runtime ""
    
    # Python
    if test -f manage.py -o -f requirements.txt -o -f pyproject.toml
        set runtime "Py"
    # Java
    else if test -f pom.xml -o -f build.gradle
        set runtime "Java"
    # Node.js
    else if test -f package.json
        set runtime "JS"
    # C/C++
    else if test -f Makefile -o -f CMakeLists.txt
        set runtime "C/C++"
    end

    if test -n "$runtime"
        set right_info "$right_info"(set_color yellow)"[$runtime] "
    end

    if set -q VIRTUAL_ENV
        set -l venv_name (basename "$VIRTUAL_ENV")
        set right_info "$right_info"(set_color cyan)"($venv_name)"
    end

    echo -n -s $right_info (set_color normal)
end
