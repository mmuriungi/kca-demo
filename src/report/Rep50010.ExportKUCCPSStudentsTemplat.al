report 50010 "Export KUCCPS Std Template"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;

            trigger OnPreDataItem()
            var
                TempBlob: Codeunit "Temp Blob";
                OutStream: OutStream;
                InStream: InStream;
                FileName: Text;
            begin
                TemplateCSV +=
                    'Ser,' +
                    'Index,' +
                    'Admin,' +
                    'Student No,' +
                    'Names,' +
                    'Gender,' +
                    'Phone,' +
                    'Alt. Phone,' +
                    'Email,' +
                    'Slt Mail,' +
                    'Box,' +
                    'Codes,' +
                    'Town,' +
                    'Prog,' +
                    'Any Other Institution Attended' +
                    CR;

                TempBlob.CreateOutStream(OutStream, TextEncoding::UTF8);
                OutStream.WriteText(TemplateCSV);

                TempBlob.CreateInStream(InStream, TextEncoding::UTF8);
                FileName := 'KUCCPS_Students_Import_Template.csv';

                File.DownloadFromStreamHandler(InStream, 'Export Template', '', 'CSV Files (*.csv)|*.csv', FileName);
            end;
        }
    }

    var
        TemplateCSV: Text;
        CR: Char;
        File: Codeunit "File Management";

    trigger OnInitReport()
    begin
        CR := 10;
    end;
}
