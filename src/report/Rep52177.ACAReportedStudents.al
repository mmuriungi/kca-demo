report 52177 "ACA-Reported Students"
{
    Caption = 'ACA-Reported Students';
    RDLCLayout = './Layouts/ReportedStudentsReport.rdl';
    dataset
    {
        dataitem(ACAApplicFormHeader; "ACA-Applic. Form Header")
        {
            column(Application_No_; "Application No.")
            {

            }
            column(AdmissionNo_ACAApplicFormHeader; "Admission No")
            {
            }
            column(firstName_ACAApplicFormHeader; firstName)
            {
            }
            column(OtherNames_ACAApplicFormHeader; "Other Names")
            {
            }
            column(Surname_ACAApplicFormHeader; Surname)
            {
            }
            column(IndexNumber_ACAApplicFormHeader; "Index Number")
            {
            }
            column(ProgrammeFaculty_ACAApplicFormHeader; "Programme Faculty")
            {
            }
            column(AdmittedDepartment_ACAApplicFormHeader; "Admitted Department")
            {
            }
            column(FirstChoiceStage_ACAApplicFormHeader; "First Choice Stage")
            {
            }
            column(SettlementType_ACAApplicFormHeader; "Settlement Type")
            {
            }
            column(Gender_ACAApplicFormHeader; Gender)
            {
            }
            column(FirstChoiceSemester_ACAApplicFormHeader; "First Choice Semester")
            {
            }
            column(AcademicYear_ACAApplicFormHeader; "Academic Year")
            {
            }
            column(Campus_ACAApplicFormHeader; Campus)
            {
            }
            column(ModeofStudy_ACAApplicFormHeader; "Mode of Study")
            {
            }
            column(County_ACAApplicFormHeader; County)
            {
            }
            column(IDNumber_ACAApplicFormHeader; "ID Number")
            {
            }
            column(YearofExamination_ACAApplicFormHeader; "Year of Examination")
            {
            }
            column(Disability_ACAApplicFormHeader; Disability)
            {
            }
            column(Nationality_ACAApplicFormHeader; Nationality)
            {
            }
            column(TelephoneNo1_ACAApplicFormHeader; "Telephone No. 1")
            {
            }
            column(TelephoneNo2_ACAApplicFormHeader; "Telephone No. 2")
            {
            }
            column(StudentEmail_ACAApplicFormHeader; "Student E-mail")
            {
            }
            column(AddressforCorrespondence1_ACAApplicFormHeader; "Address for Correspondence1")
            {
            }
            column(DateOfBirth_ACAApplicFormHeader; "Date Of Birth")
            {
            }
            column(EmergencyContactName_ACAApplicFormHeader; "Emergency Contact Name")
            {
            }
            column(EmergencyContactEmail_ACAApplicFormHeader; "Emergency Contact Email")
            {
            }
            column(EmergencyContactTelephone_ACAApplicFormHeader; "Emergency Contact Telephone")
            {
            }
            column(EmergencyRelationship_ACAApplicFormHeader; "Emergency Relationship")
            {
            }
            trigger OnPreDataItem()
            begin
                if ExportCSV then begin
                    CSVBuffer.InsertEntry(LineNo, 1, 'Application_No');
                    CSVBuffer.InsertEntry(LineNo, 2, 'Admission No');
                    CSVBuffer.InsertEntry(LineNo, 3, 'Full Names');
                    CSVBuffer.InsertEntry(LineNo, 4, 'KSCE Index No');
                    CSVBuffer.InsertEntry(LineNo, 5, 'Student Status');
                    CSVBuffer.InsertEntry(LineNo, 6, 'School Code');
                    CSVBuffer.InsertEntry(LineNo, 7, 'School Name');
                    CSVBuffer.InsertEntry(LineNo, 8, 'Department Code');
                    CSVBuffer.InsertEntry(LineNo, 9, 'Department Name');
                    CSVBuffer.InsertEntry(LineNo, 10, 'Gender');
                    CSVBuffer.InsertEntry(LineNo, 11, 'Semester');
                    CSVBuffer.InsertEntry(LineNo, 12, 'Academic Year');
                    CSVBuffer.InsertEntry(LineNo, 13, 'Qualification');
                    CSVBuffer.InsertEntry(LineNo, 14, 'Campus');
                    CSVBuffer.InsertEntry(LineNo, 15, 'Mode of Study');
                    CSVBuffer.InsertEntry(LineNo, 16, 'Hostel');
                    CSVBuffer.InsertEntry(LineNo, 17, 'County');
                    CSVBuffer.InsertEntry(LineNo, 18, 'KSCE Year');
                    CSVBuffer.InsertEntry(LineNo, 19, 'Disability');
                    CSVBuffer.InsertEntry(LineNo, 20, 'Nationality');
                    CSVBuffer.InsertEntry(LineNo, 21, 'Telephone 1');
                    CSVBuffer.InsertEntry(LineNo, 22, 'Telephone 2');
                    CSVBuffer.InsertEntry(LineNo, 23, 'Student E-mail');
                    CSVBuffer.InsertEntry(LineNo, 24, 'Adress');
                    CSVBuffer.InsertEntry(LineNo, 25, 'Date of Birth');
                    CSVBuffer.InsertEntry(LineNo, 26, 'Age');
                    CSVBuffer.InsertEntry(LineNo, 27, 'Ethnicity');
                    CSVBuffer.InsertEntry(LineNo, 28, 'Emerge. Contact Name');
                    CSVBuffer.InsertEntry(LineNo, 29, 'Emerge. Contact Relationship');
                    CSVBuffer.InsertEntry(LineNo, 30, 'Emerge. Contact Telephone');
                    CSVBuffer.InsertEntry(LineNo, 31, 'Emerge. Contact E-mail ');
                    CSVBuffer.InsertEntry(LineNo, 32, 'Reporting date');


                end;
            end;

            trigger OnAfterGetRecord()
            begin
                dimVal.Reset();
                dimVal.SetRange("Dimension Code", ACAApplicFormHeader."Programme Faculty");
                if dimVal.Find('-') then begin
                    schoolName := dimVal.Name;
                end;
                dimVal.Reset();
                dimVal.SetRange("Dimension Code", ACAApplicFormHeader."Admitted Department");
                if dimVal.Find('-') then begin
                    departName := dimVal.Name;
                end;
                Intake.Reset();
                Intake.SetRange(Faculty, ACAApplicFormHeader."Programme Faculty");
                Intake.SetRange(Current, True);
                if Intake.Find('-') then begin
                    ReportingDate := Format(Intake."Reporting Date", 0, 4);
                end;
                if ExportCSV then begin
                    LineNo := LineNo + 1;
                    CSVBuffer.InsertEntry(LineNo, 1, ACAApplicFormHeader."Application No.");
                    CSVBuffer.InsertEntry(LineNo, 2, ACAApplicFormHeader."Admission No");
                    CSVBuffer.InsertEntry(LineNo, 3, ACAApplicFormHeader.firstName + ' ' + ACAApplicFormHeader."Other Names" + ' ' + ACAApplicFormHeader.Surname);
                    CSVBuffer.InsertEntry(LineNo, 4, ACAApplicFormHeader."Index Number");
                    //CSVBuffer.InsertEntry(LineNo, 5, ACAApplicFormHeader.Surname);
                    CSVBuffer.InsertEntry(LineNo, 6, ACAApplicFormHeader."Programme Faculty");
                    CSVBuffer.InsertEntry(LineNo, 7, schoolName);
                    CSVBuffer.InsertEntry(LineNo, 8, ACAApplicFormHeader."Admitted Department");
                    CSVBuffer.InsertEntry(LineNo, 9, departName);
                    CSVBuffer.InsertEntry(LineNo, 10, Format(ACAApplicFormHeader.Gender));
                    CSVBuffer.InsertEntry(LineNo, 11, ACAApplicFormHeader."First Choice Semester");
                    CSVBuffer.InsertEntry(LineNo, 12, ACAApplicFormHeader."Academic Year");
                    CSVBuffer.InsertEntry(LineNo, 13, Format(ACAApplicFormHeader."Programme Level"));
                    CSVBuffer.InsertEntry(LineNo, 14, ACAApplicFormHeader.Campus);
                    CSVBuffer.InsertEntry(LineNo, 15, ACAApplicFormHeader."Mode of Study");
                    CSVBuffer.InsertEntry(LineNo, 16, '');
                    CSVBuffer.InsertEntry(LineNo, 17, ACAApplicFormHeader.County);
                    CSVBuffer.InsertEntry(LineNo, 18, Format(ACAApplicFormHeader."Year of Examination"));
                    CSVBuffer.InsertEntry(LineNo, 19, Format(ACAApplicFormHeader.Nationality));
                    CSVBuffer.InsertEntry(LineNo, 20, ACAApplicFormHeader."Telephone No. 1");
                    CSVBuffer.InsertEntry(LineNo, 21, ACAApplicFormHeader."Telephone No. 2");
                    CSVBuffer.InsertEntry(LineNo, 22, Format(ACAApplicFormHeader."Programme Level"));
                    CSVBuffer.InsertEntry(LineNo, 23, ACAApplicFormHeader."Student E-mail");
                    CSVBuffer.InsertEntry(LineNo, 24, ACAApplicFormHeader."Address for Correspondence1");
                    CSVBuffer.InsertEntry(LineNo, 25, Format(ACAApplicFormHeader."Date Of Birth"));
                    CSVBuffer.InsertEntry(LineNo, 26, ACAApplicFormHeader.GetAge(ACAApplicFormHeader."Date Of Birth"));
                    CSVBuffer.InsertEntry(LineNo, 27, '');
                    CSVBuffer.InsertEntry(LineNo, 28, Format(ACAApplicFormHeader."Programme Level"));
                    CSVBuffer.InsertEntry(LineNo, 29, ACAApplicFormHeader."Emergency Contact Name");
                    CSVBuffer.InsertEntry(LineNo, 30, ACAApplicFormHeader."Emergency Telephone");
                    CSVBuffer.InsertEntry(LineNo, 31, ACAApplicFormHeader."Emergency Contact Email");
                    CSVBuffer.InsertEntry(LineNo, 32, ReportingDate);
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
            FileName := 'Reported Students.csv';
            CSVBuffer.SaveDataToBlob(TempBlob, ',');
            TempBlob.CreateInStream(InStr);
            DownloadFromStream(InStr, '', '', '', FileName);
        end;
    end;

    var
        ExportCSV: Boolean;
        LineNo: Integer;
        InStr: InStream;
        Intake: Record "ACA-Intake";
        TempBlob: Codeunit "Temp Blob";
        FileMgt: Codeunit "File Management";
        FileName, schoolName, departName, ReportingDate : Text;
        CSVBuffer: Record "CSV Buffer" temporary;
        CI: Record "Company Information";
        dimVal: Record "Dimension Value";
}
