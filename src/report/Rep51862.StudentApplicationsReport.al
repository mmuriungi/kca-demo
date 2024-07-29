report 51862 "Student Applications Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Student Applications Report.rdl';

    dataset
    {
        dataitem(DataItem1000000000; "ACA-Applic. Form Header")
        {
            RequestFilterFields = "Settlement Type", "First Choice Semester", "First Degree Choice", "Programme Faculty";
            column(no; "Application No.")
            {
            }
            column(firstName; firstName)
            {

            }
            column(Other_Names; "Other Names")
            {
            }
            column(Surname; Surname)
            {
            }
            column(Settlement_Type; "Settlement Type")
            {
            }
            column(Date; Date)
            {
            }
            column(regno; "Admission No")
            {
            }
            column(Name; Surname + ' ' + "Other Names")
            {
            }
            column(sur; "Other Names")
            {
            }
            column(dob; "Date Of Birth")
            {
            }
            column(gender; Gender)
            {
            }
            column(address; "Address for Correspondence1" + ' ' + "Address for Correspondence2")
            {
            }
            column(n; "Address for Correspondence2")
            {
            }
            column(phone; "Telephone No. 1")
            {
            }
            column(degree; "First Degree Choice")
            {
            }
            column(picture; CI.Picture)
            {
            }
            column(Campus; Campus)
            {
            }
            column(Semester; "First Choice Semester")
            {
            }
            column(ProgName; ProgName)
            {
            }
            column(Status; Status)
            {
            }
            column(Programme_Faculty; "Programme Faculty")
            {

            }
            column(compName; CI.Name)
            {

            }
            column(Student_E_mail; "Student E-mail")
            {

            }
            column(Admission_No; "Admission No")
            {

            }
            column(Index_Number; "Index Number")
            {

            }
            column(programName; programName)
            {

            }
            column(schoolName; schoolName)
            {

            }
            trigger OnPreDataItem()
            begin
                if ExportCSV then begin
                    CSVBuffer.InsertEntry(LineNo, 1, 'Application_No');
                    CSVBuffer.InsertEntry(LineNo, 2, 'First Name');
                    CSVBuffer.InsertEntry(LineNo, 3, 'Middle Name');
                    CSVBuffer.InsertEntry(LineNo, 4, 'Last Name');
                    CSVBuffer.InsertEntry(LineNo, 5, 'Admission No');
                    CSVBuffer.InsertEntry(LineNo, 6, 'date of birth');
                    CSVBuffer.InsertEntry(LineNo, 7, 'Student Email');
                    CSVBuffer.InsertEntry(LineNo, 8, 'Index No');
                    CSVBuffer.InsertEntry(LineNo, 9, 'Program Code');
                    CSVBuffer.InsertEntry(LineNo, 10, 'Program Name');
                    CSVBuffer.InsertEntry(LineNo, 11, 'School Code');
                    CSVBuffer.InsertEntry(LineNo, 12, 'School Name');
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                ProgName := '';
                IF prog.GET("First Degree Choice") THEN BEGIN
                    ProgName := prog.Description;
                END;
                dimVal.Reset();
                dimVal.SetRange("Dimension Code", DataItem1000000000."Programme Faculty");
                if dimVal.Find('-') then begin

                end;
                if ExportCSV then begin
                    LineNo := LineNo + 1;
                    CSVBuffer.InsertEntry(LineNo, 1, DataItem1000000000."Application No.");
                    CSVBuffer.InsertEntry(LineNo, 2, DataItem1000000000.firstName);
                    CSVBuffer.InsertEntry(LineNo, 3, DataItem1000000000."Other Names");
                    CSVBuffer.InsertEntry(LineNo, 4, DataItem1000000000.Surname);
                    CSVBuffer.InsertEntry(LineNo, 5, DataItem1000000000."Admission No");
                    CSVBuffer.InsertEntry(LineNo, 6, format(DataItem1000000000."Date Of Birth"));
                    CSVBuffer.InsertEntry(LineNo, 7, DataItem1000000000."Student E-mail");
                    CSVBuffer.InsertEntry(LineNo, 8, DataItem1000000000."Index Number");
                    CSVBuffer.InsertEntry(LineNo, 9, DataItem1000000000."First Degree Choice");
                    CSVBuffer.InsertEntry(LineNo, 10, DataItem1000000000.programName);
                    CSVBuffer.InsertEntry(LineNo, 11, DataItem1000000000."Programme Faculty");
                    CSVBuffer.InsertEntry(LineNo, 12, schoolName);

                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ExportCSV; ExportCSV)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Export to CSV?';
                    }
                }
            }
        }
        actions
        {
        }
    }

    labels
    {
    }


    trigger OnPreReport()
    begin
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
        if ExportCSV then
            LineNo := 1;
    end;

    trigger OnPostReport()
    begin
        if ExportCSV then begin
            FileName := 'Admissions.csv';
            CSVBuffer.SaveDataToBlob(TempBlob, ',');
            TempBlob.CreateInStream(InStr);
            DownloadFromStream(InStr, '', '', '', FileName);
        end;
    end;

    var
        CI: Record "Company Information";
        prog: Record "ACA-Programme";
        ProgName: Text[100];
        ExportCSV: Boolean;
        LineNo: Integer;
        CSVBuffer: Record "CSV Buffer" temporary;
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
        FileMgt: Codeunit "File Management";
        FileName, schoolName : Text;
        dimVal: Record "Dimension Value";
}

