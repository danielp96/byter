import sys.io.File;

using StringTools;


class Byter
{
    // controls whether output is in binary or hex
    private static var bin:Bool = true;

    private static var inPath:String = "code.asm";
    private static var outPath:String = "code.data";

    private static var exitCode:Int = 0;

    public static function main()
    {
        argProcess();

        var binLineCount:UInt = 0;

        var lines:Array<String> = File.getContent(inPath).split("\n");

        var labels = new Map<String, UInt>();

        var variables = new Map<String, UInt>();

        var outFile = File.write(outPath, bin);
        outFile.bigEndian = true;

        for (i in 0...lines.length)
        {
            lines[i] = removeComment(lines[i].trim());

            if (lines[i] == "") continue;

            // process labels
            if (lines[i].charAt(0) == ":")
            {
                var label = lines[i].substring(1);

                if (labels.exists(label))
                {
                    error("Duplicate label: " + label , i+1);
                }

                labels[label] = binLineCount;

                lines[i] = "";
                continue;
            }

            // find and replace labels
            if (lines[i].contains(":"))
            {
                var label = lines[i].substring(lines[i].indexOf(":")+1);

                if (labels.exists(label))
                {
                    lines[i] = lines[i].replace(":"+label, "0x"+labels[label].hex(3));
                }
                else
                {
                    error("Undeclared label: " + label , i+1);
                }
            }

            // process variables declaration at specific address
            if (lines[i].charAt(0) == "@")
            {
                var variable = lines[i].substring(1, lines[i].lastIndexOf(" "));

                if (variables.exists(variable))
                {
                    error("Duplicate variable: " + variable , i+1);
                }

                variables[variable] = Std.parseInt(lines[i].substring(lines[i].lastIndexOf(" ")+1));

                lines[i] = "";
                continue;
            }

            if (lines[i].contains("@"))
            {
                var variable = lines[i].substring(lines[i].indexOf("@")+1);

                if (variables.exists(variable))
                {
                    lines[i] = lines[i].replace("@"+variable, "0x"+variables[variable].hex(3));
                }
                else
                {
                    error("Undeclared variable: " + variable , i+1);
                }

            }

            // process $ notation
            while (lines[i].contains("$"))
            {
                lines[i] = switch (lines[i].charAt(lines[i].indexOf("$")+1))
                {
                    case "L": lines[i].replace("$L", "0xE");
                    case "M": lines[i].replace("$M", "0xF");
                    case "0","1","2","3",
                         "4","5","6","7",
                         "8","9","A","B",
                         "C","D","E","F": lines[i].replace("$", "0x");
                    case _: {error("Unkown register.", i+1);  "";}
                }
            }

            // opcodes
            lines[i] = opcode(lines[i]);

            // error handling
            if (lines[i] == "e")
            {
                error("Invalid Instruction.", i+1);
            }

            binLineCount += 1;
        }

        for (line in lines.iterator())
        {
            // remove empty lines
            if (line == "") continue;

            if (bin)
            {
               outFile.writeUInt16(Std.parseInt("0x"+line));
            }
            else
            {
                outFile.writeString(line + "\n");
            }
        }

        outFile.close();
        Sys.exit(exitCode);
    }

    private static function argProcess()
    {
        var args = Sys.args();

        if (args.length == 0 || args[0] == "--help" || args[0] == "-h")
        {
            Sys.println("Usage:");
            Sys.println("    byterc input output [FORMAT]");
            Sys.println("\n    -b\t\toutput binary data");
            Sys.println("    -h\t\toutput hexadecimal txt");

            Sys.println("\nIf FORMAT not specified defaults to binary.");

            Sys.exit(0);
        }

        inPath = args[0];
        outPath = args[1];

        if (args.length == 3)
        {
            bin = switch (args[2])
            {
                case "-b": true;
                case "-h": false;
                case _: true;
            }
        }
    }

    // bin: true for binary output, false for hex output
    private static function opcode(instruction:String)
    {
        var instr = instruction.split(" ");

        return switch (instr[0])
        {
            case "NOP": "0000";
            case "AND":  "01" + numFormat(instr[1]) + numFormat(instr[2]);
            case "OR":   "02" + numFormat(instr[1]) + numFormat(instr[2]);
            case "NOT":  "03" + numFormat(instr[1]) + numFormat(instr[2]);
            case "XOR":  "04" + numFormat(instr[1]) + numFormat(instr[2]);
            case "ADD":  "05" + numFormat(instr[1]) + numFormat(instr[2]);
            case "SUB":  "06" + numFormat(instr[1]) + numFormat(instr[2]);
            case "SWAP": "07" + numFormat(instr[1]) + numFormat(instr[2]);

            case "RETURN": "08" + "00";
            case "RETURNL": "09" + numFormat(instr[1]);

            case "MOV":  "0A" + numFormat(instr[1]) + numFormat(instr[2]);
            case "LSL":  "0B" + numFormat(instr[1]) + numFormat(instr[2]);
            case "LSR":  "0C" + numFormat(instr[1]) + numFormat(instr[2]);
            case "CSL":  "0D" + numFormat(instr[1]) + numFormat(instr[2]);
            case "CSR":  "0E" + numFormat(instr[1]) + numFormat(instr[2]);
            case "IN":   "0F" + numFormat(instr[1]) + numFormat(instr[2]);
            case "OUT":  "10" + numFormat(instr[1]) + numFormat(instr[2]);
            case "CMP":  "11" + numFormat(instr[1]) + numFormat(instr[2]);
            case "INC":  "12" + numFormat(instr[1]) + numFormat(instr[2]);
            case "DEC":  "13" + numFormat(instr[1]) + numFormat(instr[2]);
            case "LIT":  "14" + numFormat(instr[1]);
            case "SETB": "15" + numFormat(instr[1]) + numFormat(instr[2]);
            case "CLRB": "16" + numFormat(instr[1]) + numFormat(instr[2]);

            case "PUSH": "17" + "0" + numFormat(instr[1]);

            case "POP":  "18" + numFormat(instr[1]) + "0";

            case "PCADD": "19" + "00";
            case "CALL":  "2" + numFormat(instr[1], 3);
            case "JMP":   "3" + numFormat(instr[1], 3);
            case "JC":    "4" + numFormat(instr[1], 3);
            case "JNC":   "5" + numFormat(instr[1], 3);
            case "JZ":    "6" + numFormat(instr[1], 3);
            case "JNZ":   "7" + numFormat(instr[1], 3);
            case "STORE": "8" + numFormat(instr[1], 3);
            case "LOAD":  "9" + numFormat(instr[1], 3);

            case "": "";
            case _: "e";
        }
    }

    private static function numFormat(num:String, padding:Int=0):String
    {
        return switch (num.charAt(0))
        {
            // hex
            case "0": Std.parseInt(num).hex(padding);

            // dec
            case ".": Std.parseInt(num.substring(1)).hex(padding);

            // bin
            case "b": bin2hex(num.substring(1));

            case _: "";
        };
    }

    private static function bin2hex(bin:String):String
    {
        var num = 0;

        for (i in 0...bin.length)
        {
            var pos = bin.length-i-1;


            var n = Std.parseInt(bin.charAt(pos));

            num += n*(1<<i);
        }

        return num.hex();
    }

    private static function removeComment(text:String)
    {
        var commentPos = text.indexOf("//");

        if (commentPos != -1)
        {
            text = text.substring(0, commentPos);
        }

        text = text.replace("  ", " ");

        return text;
    }

    private static function error(msg:String, lineNumber:UInt):Void
    {
        Sys.println(lineNumber + ": " + msg);
        exitCode = -1;
    }
}