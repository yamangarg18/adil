fun readFileLineByLine filename =
    let
        val inFile = TextIO.openIn filename
        val lines = ref []
    in
        while not (TextIO.endOfStream inFile) do
            lines := TextIO.inputLine inFile :: !lines
        done;
        TextIO.closeIn inFile;
        rev !lines
    end;

fun editLine line =
    String.translate (fn #"foo" => #"bar", c => c) line;

fun writeFile filename lines =
    let
        val outFile = TextIO.openOut filename
    in
        app (fn line => TextIO.output (outFile, line ^ "\n")) lines;
        TextIO.closeOut outFile;
    end;
fun convert_to_html (filename: string, output_file: string) = 
  let
    val in_stream = TextIO.openIn input_file
    val out_stream = TextIO.openOut output_file
    val content = TextIO.inputAll in_stream
  in
    TextIO.output (out_stream, "<html><body>" ^ content ^ "</body></html>");
    TextIO.closeIn in_stream;
    TextIO.closeOut out_stream
  end;

val input_file = “filename.mdt"
val output_file = “filename.html"

fun main (filename :: _) =
    let
        val lines = readFileLineByLine filename
        val editedLines = map editLine lines
    in
        writeFile filename editedLines
	convert_to_html (filename, output_file)
    end;
