page 50606 "HRM-Employee"
{
    Caption = 'Employee Card';
    DelayedInsert = false;
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "HRM-Employee C";

    layout
    {
        area(content)
        {
            group(Control206)
            {
                Editable = false;
                ShowCaption = false;
                field("gOpt Active"; "gOpt Active")
                {
                    OptionCaption = 'Show Active Employees,Show Archived Employees,Show All Employees';
                    ShowCaption = false;

                    trigger OnValidate()
                    begin
                        if "gOpt Active" = "gOpt Active"::All then
                            AllgOptActiveOnValidate;
                        if "gOpt Active" = "gOpt Active"::Archive then
                            ArchivegOptActiveOnValidate;
                        if "gOpt Active" = "gOpt Active"::Active then
                            ActivegOptActiveOnValidate;
                    end;
                }
                field("Employee Act. Qty"; Rec."Employee Act. Qty")
                {
                    Editable = false;
                }
                field("Employee Arc. Qty"; Rec."Employee Arc. Qty")
                {
                    Editable = false;
                }
                field("Employee Qty"; Rec."Employee Qty")
                {
                    Editable = false;
                }
            }
            group("General Information")
            {
                Caption = 'General Information';
                field("No."; Rec."No.")
                {
                    AssistEdit = true;
                    Editable = true;
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Known As"; Rec."Known As")
                {
                }
                field(Initials; Rec.Initials)
                {
                }
                field("ID Number"; Rec."ID Number")
                {
                }
                field("Passport Number"; Rec."Passport Number")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field(Citizenship; Rec.Citizenship)
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Postal Address"; Rec."Postal Address")
                {
                }
                field("Postal Address2"; Rec."Postal Address2")
                {
                }
                field("Postal Address3"; Rec."Postal Address3")
                {
                }
                field("Post Code2"; Rec."Post Code2")
                {
                    Caption = 'Post Code';
                    LookupPageID = "Post Codes";
                }
                field("Residential Address"; Rec."Residential Address")
                {
                }
                field("Residential Address2"; Rec."Residential Address2")
                {
                }
                field("Residential Address3"; Rec."Residential Address3")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(Picture; Rec.Picture)
                {
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Rec.Gender)
                {
                }
                field("Marital Status"; Rec."Marital Status")
                {
                }
                field(Religion; Rec.Religion)
                {
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                }
                field(Tribe; Rec.Tribe)
                {
                }
                field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                {
                }
                field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                {
                }
                field("Additional Language"; Rec."Additional Language")
                {
                }
                field("First Language Write"; Rec."First Language Write")
                {
                }
                field("Second Language Write"; Rec."Second Language Write")
                {
                }
                field("Driving Licence"; Rec."Driving Licence")
                {
                }
                field("First Language Speak"; Rec."First Language Speak")
                {
                }
                field("Second Language Speak"; Rec."Second Language Speak")
                {
                }
                field(Disabled; Rec.Disabled)
                {

                    trigger OnValidate()
                    begin
                        if Rec.Disabled = Rec.Disabled::No then begin
                            "Disabling DetailsEditable" := false;
                            "Disability GradeEditable" := false;
                        end
                        else
                            "Disabling DetailsEditable" := true;
                        "Disability GradeEditable" := true;
                    end;
                }
                field("Disabling Details"; Rec."Disabling Details")
                {
                    Editable = "Disabling DetailsEditable";
                }
                field("Disability Grade"; Rec."Disability Grade")
                {
                    Editable = "Disability GradeEditable";
                }
                field("Health Assesment?"; Rec."Health Assesment?")
                {
                    Caption = 'Health Assessment?';
                }
                field("Medical Scheme No."; Rec."Medical Scheme No.")
                {
                }
                field("Medical Scheme Head Member"; Rec."Medical Scheme Head Member")
                {
                }
                field("Number Of Dependants"; Rec."Number Of Dependants")
                {
                }
                field("Medical Scheme Name"; Rec."Medical Scheme Name")
                {
                }
                field("Medical Scheme Name #2"; Rec."Medical Scheme Name #2")
                {
                }
                field("Health Assesment Date"; Rec."Health Assesment Date")
                {
                    Caption = 'Health Assessment Date';
                }
                group("  R      W     S")
                {
                    Caption = '  R      W     S';
                    field("First Language Read"; Rec."First Language Read")
                    {
                    }
                    field("Second Language Read"; Rec."Second Language Read")
                    {
                    }
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                }
                field(DAge; DAge)
                {
                    Caption = 'Age';
                    Editable = false;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    Caption = 'Date Of Joining The Company';
                }
                field(DService; DService)
                {
                    Caption = 'Length of Service';
                    Editable = false;
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                }
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                    Caption = 'Pension Scheme Join Date';
                }
                field(DPension; DPension)
                {
                    Caption = 'Time On Pension Scheme';
                    Editable = false;
                }
                field("Medical Scheme Join"; Rec."Medical Scheme Join")
                {
                    Caption = 'Medical Aid Scheme Join Date';
                }
                field(DMedical; DMedical)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field("Wedding Anniversary"; Rec."Wedding Anniversary")
                {
                }
            }
            group("Contact Numbers")
            {
                Caption = 'Contact Numbers';
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                }
                field("Fax Number"; Rec."Fax Number")
                {
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                }
                field("Ext."; Rec."Ext.")
                {
                }
                field("Post Office No"; Rec."Post Office No")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                }
            }
            group("Job Information")
            {
                Caption = 'Job Information';
                field(Position; Rec.Position)
                {
                    Caption = 'Job Position';
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Name Of Manager"; Rec."Name Of Manager")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        "Rec HR Employee": Record "HRM-Employee C";
                    begin
                        /*
                        "Form HR Employee".LOOKUPMODE(TRUE);
                        IF ("Form HR Employee".RUNMODAL = ACTION::LookupOK) THEN
                           "Form HR Employee".GETRECORD("Rec HR Employee");
                        
                        "Name Of Manager" := "Rec HR Employee"."Known As" + ' ' + "Rec HR Employee"."Last Name";
                        "Manager Emp No":="Rec HR Employee"."No.";
                         */

                    end;
                }
                field("Grade Level"; Rec."Grade Level")
                {
                }
                field("2nd Skills Category"; Rec."2nd Skills Category")
                {
                    Visible = false;
                }
                field("3rd Skills Category"; Rec."3rd Skills Category")
                {
                    Visible = false;
                }
                field("Primary Skills Category"; Rec."Primary Skills Category")
                {
                    Visible = false;
                }
            }
            group("Contract Information")
            {
                Caption = 'Contract Information';
                field("Contract Location"; Rec."Contract Location")
                {
                    Caption = 'Location';
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                }
                field(Permanent; Rec.Permanent)
                {
                    Caption = 'Payroll Permanent';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                }
                field("Notice Period"; Rec."Notice Period")
                {
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("Department Code"; Rec."Department Code")
                {
                    Caption = 'Department';
                }
                field("Payroll Departments"; Rec."Payroll Departments")
                {
                    Caption = 'Cost Center';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                }
                field("HELB No"; Rec."HELB No")
                {
                }
                field("Co-Operative No"; Rec."Co-Operative No")
                {
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                }
                field("Main Bank"; Rec."Main Bank")
                {
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    Caption = 'HR Posting Group';
                }
                field("Payroll Posting Group"; Rec."Payroll Posting Group")
                {
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                }
                field("Holiday Days Entitlement"; Rec."Holiday Days Entitlement")
                {
                }
                field("Holiday Days Used"; Rec."Holiday Days Used")
                {
                }
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                }
            }
            group(Separation)
            {
                Caption = 'Separation';
                field("Contract Type1"; Rec."Contract Type")
                {
                }
                field("Contract End Date1"; Rec."Contract End Date")
                {
                }
                field("Notice Period1"; Rec."Notice Period")
                {
                }
                field("Send Alert to1"; Rec."Send Alert to")
                {
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    Caption = 'Date Of Leaving The Company';
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    Caption = 'Exit Category';

                    trigger OnValidate()
                    begin
                        if Rec."Termination Category" <> Rec."Termination Category"::" " then
                            Rec.Status := Rec.Status::Disabled;
                    end;
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    Caption = 'Grounds for Exit';
                }
                field(Status; Rec.Status)
                {
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                }
                field("Allow Re-Employment In Future"; Rec."Allow Re-Employment In Future")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        //Recalculate Important Dates
        /* IF ("Date Of Leaving" = 0D) THEN BEGIN
           IF  ("Date Of Birth" <> 0D) THEN
           DAge:= Dates.DetermineAge("Date Of Birth",TODAY);
           IF  ("Date Of Join" <> 0D) THEN
           DService:= Dates.DetermineAge("Date Of Join",TODAY);
           IF  ("Pension Scheme Join" <> 0D) THEN
           DPension:= Dates.DetermineAge("Pension Scheme Join",TODAY);
           IF  ("Medical Scheme Join" <> 0D) THEN
           DMedical:= Dates.DetermineAge("Medical Scheme Join",TODAY);
           //MODIFY;
         END ELSE BEGIN
           IF  ("Date Of Birth" <> 0D) THEN
           DAge:= Dates.DetermineAge("Date Of Birth","Date Of Leaving");
           IF  ("Date Of Join" <> 0D) THEN
           DService:= Dates.DetermineAge("Date Of Join","Date Of Leaving");
           IF  ("Pension Scheme Join" <> 0D) THEN
           DPension:= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
           IF  ("Medical Scheme Join" <> 0D) THEN
           DMedical:= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
          // MODIFY;
         END; */

    end;

    trigger OnInit()
    begin
        "Disability GradeEditable" := true;
        "Disabling DetailsEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //RESET;
        "gOpt Active" := "gOpt Active"::All;
        //MESSAGE('All employee information must be completed.')
    end;

    trigger OnOpenPage()
    begin
        "gOpt Active" := "gOpt Active"::Active;
        Rec.SetCurrentKey("Termination Category");
        "Filter Employees"(0);
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        //Recalculate Important Dates
        /*IF ("Date Of Leaving" = 0D) THEN BEGIN
          IF  ("Date Of Birth" <> 0D) THEN
          DAge:= Dates.DetermineAge("Date Of Birth",TODAY);
          IF  ("Date Of Join" <> 0D) THEN
          DService:= Dates.DetermineAge("Date Of Join",TODAY);
          IF  ("Pension Scheme Join" <> 0D) THEN
          DPension:= Dates.DetermineAge("Pension Scheme Join",TODAY);
          IF  ("Medical Scheme Join" <> 0D) THEN
          DMedical:= Dates.DetermineAge("Medical Scheme Join",TODAY);
          //MODIFY;
        END ELSE BEGIN
          IF  ("Date Of Birth" <> 0D) THEN
          DAge:= Dates.DetermineAge("Date Of Birth","Date Of Leaving");
          IF  ("Date Of Join" <> 0D) THEN
          DService:= Dates.DetermineAge("Date Of Join","Date Of Leaving");
          IF  ("Pension Scheme Join" <> 0D) THEN
          DPension:= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
          IF  ("Medical Scheme Join" <> 0D) THEN
          DMedical:= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
          //MODIFY;
        END;*/
        //VALIDATE("Contract End Date");

    end;

    var
        //Mail: Codeunit Mail;
        PictureExists: Boolean;
        "gOpt Active": Option Active,Archive,All;
        D: Date;
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        currentmonth: Date;
        [InDataSet]
        "Disabling DetailsEditable": Boolean;
        [InDataSet]
        "Disability GradeEditable": Boolean;

    procedure "Filter Employees"(Type: Option Active,Archive,All)
    begin


        if Type = Type::Active then begin
            Rec.Reset;
            Rec.SetFilter("Termination Category", '=%1', Rec."Termination Category"::" ");
        end
        else
            if Type = Type::Archive then begin
                Rec.Reset;
                Rec.SetFilter("Termination Category", '>%1', Rec."Termination Category"::" ");
            end
            else
                if Type = Type::All then
                    Rec.Reset;

        CurrPage.Update(false);
        Rec.FilterGroup(20);
    end;

    local procedure ActivegOptActiveOnPush()
    begin
        "Filter Employees"(0); //Active Employees
    end;

    local procedure ArchivegOptActiveOnPush()
    begin
        "Filter Employees"(1); //Archived Employees
    end;

    local procedure AllgOptActiveOnPush()
    begin
        "Filter Employees"(2); //  Show All Employees
    end;

    local procedure ActivegOptActiveOnValidate()
    begin
        ActivegOptActiveOnPush;
    end;

    local procedure ArchivegOptActiveOnValidate()
    begin
        ArchivegOptActiveOnPush;
    end;

    local procedure AllgOptActiveOnValidate()
    begin
        AllgOptActiveOnPush;
    end;

    procedure GetSupervisor(var sUserID: Code[20]) SupervisorName: Text[200]
    var
        UserSetup: Record "User Setup";
        HREmp: Record "HRM-Employee C";
    begin
        if sUserID <> '' then begin
            UserSetup.Reset;
            if UserSetup.Get(sUserID) then begin

                SupervisorName := UserSetup."Approver ID";
                if SupervisorName <> '' then begin

                    HREmp.SetRange(HREmp."User ID", SupervisorName);
                    if HREmp.Find('-') then
                        SupervisorName := HREmp.FullName;

                end else begin
                    SupervisorName := '';
                end;


            end else begin
                Error('User' + ' ' + sUserID + ' ' + 'does not exist in the user setup table');
                SupervisorName := '';
            end;
        end;
    end;
}

