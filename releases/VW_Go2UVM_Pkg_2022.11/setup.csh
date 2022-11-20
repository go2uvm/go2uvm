echo "**********************************************"
echo "Welcome to Go2UVM setup!"
echo "This script will setup necessary environment "
echo "variables for a smooth route to Go2UVM"
echo "..............................................\n"

setenv VW_GO2UVM_HOME `pwd`
#setenv PATH ${PATH}:${VW_GO2UVM_HOME}/bin

set py_ver = `which python ` 
if ($py_ver == "") then
    echo "Python is not installed"
else
    echo $py_ver
    echo "Python version found"
    python -V
endif

echo "..............................................\n"
echo "Done setting it up!"
echo "Ready to Go2UVM!"
echo "Using VW_GO2UVM_HOME as: \n$VW_GO2UVM_HOME"
echo "**********************************************"

