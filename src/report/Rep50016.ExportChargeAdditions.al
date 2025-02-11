report 50016 "Export Charge Additions"
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
                    'Student No.,' +
                    'Student Name,' +
                    'Stage,' +
                    'Charge Code,' +
                    'Amount,' +
                    'Academic Year,' +
                    'Semester,' +
                    CR;

                TempBlob.CreateOutStream(OutStream, TextEncoding::UTF8);
                OutStream.WriteText(TemplateCSV);

                TempBlob.CreateInStream(InStream, TextEncoding::UTF8);
                FileName := 'Student_Charges_Import_Template.csv';

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

