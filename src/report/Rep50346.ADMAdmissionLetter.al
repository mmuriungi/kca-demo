report 50346 "ADM Admission Letter"
{

    ApplicationArea = All;
    DefaultLayout = WORD;
    WordLayout = './Layouts/bachelorsAdmissionLetters.docx';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    EnableHyperlinks = true;

    dataset
    {
        dataitem(bAdmLetter; "ACA-Applic. Form Header")
        {
            column(Admission_No; "Admission No")
            {

            }
            column(Application_No_; "Application No.")
            {

            }
            column(programName; programName)
            {

            }
            column(Programme_Faculty; "Programme Faculty")
            {

            }

            column(Application_Date; format("Application Date"))
            {

            }
            column(Other_Names; "Other Names")
            {

            }
            column(firstName; firstName)
            {

            }
            column(Surname; Surname)
            {

            }
            column(First_Degree_Choice; "First Degree Choice")
            {

            }
            column(CompanyInformation; CompanyInformation.Picture)
            {

            }

            column(totalFee; format(totalFee))
            {

            }
            column(Intake_Code; "Intake Code")
            {

            }
            column(ReportingDate; format(ReportingDate))
            {

            }
            column(Date_of_Admission; format("Date of Admission"))
            {

            }
            column(name; CompanyInformation.Name)
            {

            }
            column(faculty; faculty)
            {

            }
            column(Settlement_Type; "Settlement Type")
            {

            }
            column(EndDateText; EndDateText)
            {

            }
            column(appDate; appDate)
            {

            }
            column(Campus; Campus)
            {

            }
            column(campusText; campusText)
            {

            }
            column(letterHead; letterHead)
            {

            }
            column(letterHead2; letterHead2)
            {

            }
            column(letterHead3; letterHead3)
            {

            }
            column(letterHead4; letterHead4)
            {

            }
            column(footer1; footer1)
            {

            }
            column(footer2; footer2)
            {

            }
            column(footer3; footer3)
            {

            }
            column(semOneFee; Format(semOneFee))
            {

            }
            column(semTwoFee; Format(semTwoFee))
            {

            }
            column(Telephone_No__1; "Telephone No. 1")
            {

            }
            column(Telephone_No__2; "Telephone No. 2")
            {

            }
            column(Address_for_Correspondence1; "Address for Correspondence1")
            {

            }
            column(Address_for_Correspondence3; "Address for Correspondence3")
            {

            }
            column(Student_E_mail; "Student E-mail")
            {

            }
            column(pName; pName)
            {

            }
            column(applicDate; applicDate)
            {

            }




            trigger OnAfterGetRecord()
            begin
                intakeFees.Reset();
                intakeFees.SetRange(ProgCode, bAdmLetter."First Degree Choice");
                if intakeFees.Find('-') then begin
                    semOneFee := intakeFees.sem1Fee;
                    semTwoFee := intakeFees.sem2Fee;
                    totalFee := semOneFee + semTwoFee;

                end;
                apps.Reset();
                apps.SetRange("Application No.", bAdmLetter."Application No.");
                if apps.Find('-') then begin
                    applicDate := Format(apps."Application Date", 0, 4);
                end;
                prog.Reset();
                prog.SetRange(Code, bAdmLetter."First Degree Choice");
                if prog.Find('-') then begin
                    prog.CalcFields("Faculty Name");
                    faculty := prog."Faculty Name";
                    pName := prog.Description;
                end;
                Intake.Reset();
                Intake.SetRange(Faculty, bAdmLetter."Programme Faculty");
                Intake.SetRange(Current, True);
                if Intake.Find('-') then begin
                    ReportingDate := Format(Intake."Reporting Date", 0, 4);
                end;

            end;



        }
    }

    requestpage
    {
        layout
        {

        }

        actions
        {

        }
    }
    trigger OnInitReport()
    begin

        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        end;


    end;

    var

        CompanyInformation: Record "Company Information";
        progFee: Record "ACA-ProgramIntakeFee";
        totalFee, semOneFee, semTwoFee : Decimal;
        Intake: Record "ACA-Intake";
        ReportingDate, pName, applicDate : text;
        prog: Record "ACA-Programme";
        faculty: text[200];
        Dimn: Record "Dimension Value";
        intakeFees: Record "ACA-ProgramIntakeFee";
        EndDateText: Text;
        appDate: Text;
        gabatext: Label 'Main Hall - Gaba Campus';
        langatatext: Label 'Learning Resource Center - Langata Campus';
        provisionalAdmission: Label 'Kindly note that this provisional admission is valid for one semester subject to fullfilling the above condition.  Note that if the condition is not met the admission will stand revoked.';
        footer: Label 'If you are in agreement with the above statement kindly sign below.';
        Header1: Label 'ADMISSION';
        Header2: Label 'PROVISIONAL ADMISSION';
        Header3: Label 'provisionally';
        Header4: Label 'pending';
        Header5: Label 'an admission';
        Header6: Label 'a Provisional admission';
        campusText: text[200];
        letterHead: Text;
        letterHead2: Text;
        letterHead3: Text;
        letterHead4: Text;
        footer1: Text;
        footer2: Text;
        footer3: Text;
        apps: Record "ACA-Applic. Form Header";

    // trigger OnPreReport()
    // begin

    // end;




}