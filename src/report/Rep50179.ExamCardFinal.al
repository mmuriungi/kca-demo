report 50179 "Exam Card Final"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Exam Card Final.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = WHERE(Reversed = FILTER(false), "Units Taken" = FILTER(> 0));
            RequestFilterFields = "Student No.", Programmes, Semester, Stage, "Date Filter";
            column(Signat; usersetup."User Signature")
            {
            }
            column(ApprovalTitle; usersetup."Approval Title")
            {
            }
            column(pic; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(CompAddress; CompInf.Address + ' ' + CompInf."Address 2" + ', ' + CompInf.City)
            {
            }
            column(CompPhone; CompInf."Phone No." + ';' + CompInf."Phone No. 2")
            {
            }
            column(ComMails; CompInf."E-Mail" + '/' + CompInf."Home Page")
            {
            }
            column(StudNo; recCustomer."No.")
            {
            }
            column(StudName; recCustomer.Name)
            {
            }
            column(ProgName; txtProgramme)
            {
            }
            column(FacultyName; txtFaculty)
            {
            }
            column(studStageSem; studStageSem)
            {
            }
            column(Units_RegisteredCaption_Control1102755023; Units_RegisteredCaption_Control1102755023Lbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            column(Supervisor_Signature; SUPsIGNATURE)
            {
            }
            column(Stages; "ACA-Course Registration".Stage)
            {
            }
            column(rule1; rule1)
            {
            }
            column(rule2; rule2)
            {
            }
            column(rule3; rule3)
            {
            }
            column(rule4; rule4)
            {
            }
            column(rule5; rule5)
            {
            }
            column(rule6; rule6)
            {
            }
            column(Sems; "ACA-Course Registration".Semester)
            {
            }
            column(department; department)
            {

            }
            column(Faculty; Faculty)
            {

            }



            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."), Semester = FIELD(Semester), Programme = FIELD(Programmes);
                column(SubjCode; "ACA-Student Units".Unit)
                {
                }
                column(SubjName; subjz.Desription)
                {
                }


                trigger OnAfterGetRecord()
                begin
                    subjz.Reset;
                    subjz.SetRange("Programme Code", "ACA-Student Units".Programme);
                    subjz.SetRange(Code, "ACA-Student Units".Unit);
                    if subjz.Find('-') then begin
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if recCustomer.Get("ACA-Course Registration"."Student No.") then begin
                    recCustomer.CalcFields(recCustomer.Balance);
                    bal := recCustomer.Balance;
                end;
                sems.Reset();
                sems.Setrange(Code, "ACA-Course Registration".Semester);
                if sems.Find('-') then begin
                    if sems."DownLoad Exam Card" <> true then
                        Error('Exam Card Disabled');
                end;
                CalcFields("Units Taken");
                recProgramme.Reset();
                recProgramme.SetRange(Code, "ACA-Course Registration".Programmes);
                if recProgramme.Find('-') then begin
                    Faculty := recProgramme."Faculty Name";
                    department := recProgramme."Department Name"
                end;
                if "Units Taken" <= 0 then CurrReport.Skip;


                if (bal > 0) then begin
                    //CurrReport.Skip;
                end;

                if (bal > 0) then begin
                    //CurrReport.Skip;
                end else begin
                    Clear(studStageSem);
                    Clear(txtProgramme);
                    Clear(FacultyCode);
                    Clear(txtFaculty);

                    recProgramme.Reset;
                    recProgramme.SetRange(recProgramme.Code, "ACA-Course Registration".Programmes);
                    if recProgramme.Find('-') then begin
                        txtProgramme := recProgramme.Description;
                        FacultyCode := recProgramme."Department Code";
                    end;
                    recFaculty.Reset;
                    recFaculty.SetRange(recFaculty.Code, FacultyCode);
                    if recFaculty.Find('-') then
                        txtFaculty := recFaculty.Name;

                    studStageSem := 'Stage: ' + "ACA-Course Registration".Stage + '  Semester: ' + "ACA-Course Registration".Semester;
                end;
            end;

            trigger OnPreDataItem()
            begin

                //studCount:="ACA-Course Registration".COUNT;
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

    labels
    {
    }

    trigger OnInitReport()
    begin
        if CompInf.Get then
            CompInf.CalcFields(CompInf.Picture);

        usersetup.Reset;
        // usersetup.SetRange("Is Registrar",true);
        if usersetup.Find('-') then begin
            usersetup.CalcFields("User Signature");
        end;

    end;

    var
        usersetup: Record "User Setup";
        recProgramme: Record "ACA-Programme";
        txtProgramme: Text[100];
        recFaculty: Record "Dimension Value";
        txtFaculty: Text[100];
        FacultyCode: Code[20];
        txtNames: Text[50];
        recCustomer: Record Customer;
        bal: Decimal;
        studStageSem: Code[50];
        StudUnits: Record "ACA-Student Units";
        Units_RegisteredCaptionLbl: Label 'Units Registered';
        Units_RegisteredCaption_Control1102755023Lbl: Label 'Units Registered';
        SUPsIGNATURE: Label 'Signature of the Invigilator on Collection of the Scripts';
        compName: Label 'KARATINA UNIVERSITY';
        coursecode: Label 'COURSE CODE';
        CourseDesc: Label 'COURSE TITLE';
        creditHrs: Label 'UNITS';
        instrtitle: Label 'IMPORTANT';
        rule1: Label 'This card is NOT Transferable nor is it Replaceable';
        rule2: Label 'it MUST be presented together with the student identity card to the invigilator when required';
        rule3: Label 'The invigilator MUST sign on the card as he/she collects the scripts';
        rule4: Label 'The names which appear on the card are the same names which will appear on the certificate';
        rule5: Label 'The candidate must ensure that the order of the names are consistently written at all times i.e. surname, first Name and middle Name';
        rule6: Label 'Any error on the names must be corrected at the office of the Dean of the School in which the Candidate is registered.';
        desclaimer: Label 'This is to confirm that the information above is correct';
        desclaimersigns: Label 'Dean of the School ..................................... Stamp... ................';
        subjz: Record "ACA-Units/Subjects";
        CompInf: Record "Company Information";
        "date created": DateTime;
        sems: Record "ACA-Semesters";
        faculty, department : Text;
}

