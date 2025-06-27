table 50245 "HRM-Medical Claims"
{
    DrillDownPageId = "Medical Claims List";
    LookupPageId = "Medical Claims List";
    fields
    {
        field(1; "Member No"; Code[10])
        {
            TableRelation = "HRM-Employee C"."No.";
            trigger OnValidate()
            var
                HREmpl: Record "HRM-Employee C";
            begin
                HREmpl.RESET;
                HREmpl.SETRANGE(HREmpl."No.", "Member No");
                IF HREmpl.FIND('-') THEN BEGIN
                    "Member Names" := HREmpl."First Name" + ' ' + HREmpl."Middle Name" + ' ' + HREmpl."Last Name";

                    //HREmpl.TestField("Responsibility Center");
                    HREmpl.TestField(Campus);
                    HREmpl.TestField("Department Code");
                    //HREmpl.TestField("Faculty Code");
                    "Global Dimension 1 Code" := HREmpl.Campus;
                    "Global Dimension 2 Code" := HREmpl."Department Code";
                    "Shortcut Dimension 3 Code" := HREmpl."Faculty Code";
                    "Responsibility Center" := HREmpl."Responsibility Center";
                    HREmpl.TestField("Responsibility Center");
                end;
                SetCurrentFiscalYearFilter();
                fnCheckCeilingAndBalance();
                CheckForOverdraft();
            end;
        }
        field(2; "Claim Type"; Option)
        {
            OptionMembers = Inpatient,Outpatient,Optical;
            
            trigger OnValidate()
            begin
                // Recalculate balances when claim type changes
                if "Member No" <> '' then begin
                    SetCurrentFiscalYearFilter();
                    CalcFields("Employee Category", "Salary Grade");
                    CalcFields("Inpatient Limit", "Outpatient Limit", "Optical Limit",
                              "Inpatient Running Balance", "Outpatient Running Balance", "Optical Running Balance");
                    
                    // Re-validate claim amount with new type
                    if "Claim Amount" > 0 then begin
                        fnCheckCeilingAndBalance();
                        
                        // Check for overdraft with new claim type
                        if GetAvailableBalance("Claim Type") <= 0 then
                            CheckForOverdraft();
                    end;
                end;
            end;
        }
        field(3; "Claim Date"; Date)
        {
        }
        field(4; "Patient Name"; Text[100])
        {
        }
        field(5; "Document Ref"; Text[50])
        {
        }
        field(6; "Date of Service"; Date)
        {
        }
        field(7; "Facility Attended"; Code[10])
        {
            TableRelation = "HRM-Medical Facility".Code;

            trigger OnValidate()
            begin
                Facility.Reset;
                Facility.SetRange(Facility.Code, "Facility Attended");
                if Facility.Find('-') then begin
                    "Facility Name" := Facility."Facility Name";

                end;

            end;
        }
        field(8; "Claim Amount"; Decimal)
        {

            trigger OnValidate()
            Var
                scheme: Record "HRM-Medical Schemes";
                ExceedLimitErr: Label 'The claim amount %1 exceeds the %2 limit of %3.';
                Employee: Record "HRM-Employee C";
                AvailableBalance: Decimal;
                WarningMsg: Text;
            begin
                if "Claim Currency Code" <> "Scheme Currency Code" then begin
                    UpdateCurrencyFactor;

                    if "Claim Currency Code" <> xRec."Claim Currency Code" then
                        UpdateCurrencyFactor;
                end else begin
                    //  if "Claim Currency Code" <> MedicalSchemes.Currency then
                    // UpdateCurrencyFactor;
                end;
                if "Currency Factor" <> 0 then
                    "Scheme Amount Charged" := "Claim Amount" * "Currency Factor"
                else
                    "Scheme Amount Charged" := "Claim Amount";

                // Enhanced validation with limit checking and overdraft alerts
                if ("Member No" <> '') and ("Claim Amount" > 0) then begin
                    // Check ceiling and balance using existing function
                    fnCheckCeilingAndBalance();
                    
                    // Check available balance and send overdraft alert if needed
                    AvailableBalance := GetAvailableBalance("Claim Type");
                    
                    if "Claim Amount" > AvailableBalance then begin
                        WarningMsg := 'WARNING: Claim amount (%1) exceeds available balance (%2) for %3 claims. Proceeding will result in an overdraft.';
                        Message(WarningMsg, "Claim Amount", AvailableBalance, Format("Claim Type"));
                        
                        // Trigger overdraft alert
                        CheckForOverdraft();
                    end else if "Claim Amount" > (AvailableBalance * 0.8) then begin
                        WarningMsg := 'CAUTION: Claim amount (%1) is approaching the limit. Available balance: (%2) for %3 claims.';
                        Message(WarningMsg, "Claim Amount", AvailableBalance, Format("Claim Type"));
                    end;
                end;
            end;
        }
        field(9; Comments; Text[250])
        {
        }
        field(10; "Claim No"; Code[10])
        {

            trigger OnValidate()
            begin

                if "Claim No" <> xRec."Claim No" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Medical Claims Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(11; Dependants; Code[50])
        {
            TableRelation = "HRM-Employee Kin"."Other Names" WHERE("Employee Code" = FIELD("Member No"), Type = FILTER(Dependant));

            trigger OnValidate()
            begin
                MDependants.Reset;
                MDependants.SetRange(MDependants."Employee Code", "Member No");
                MDependants.SetRange(MDependants."Other Names", Dependants);
                if MDependants.Find('-') then begin
                    "Patient Name" := MDependants.SurName + ' ' + MDependants."Other Names";
                end;
            end;
        }
        field(3968; "Member ID"; Code[30])
        {

            trigger OnValidate()
            begin
                if HREmp.Get(HREmp."User ID") then
                    "Member No" := HREmp."No.";
                //Description:=HRTrainingNeeds.Description;

                /*
                 HREmp.RESET;
                 HREmp.SETRANGE(HREmp."User ID","Member ID");
                  IF HREmp.FIND('-') THEN BEGIN
                  "Member No":=HREmp."No.";
                 "Member Names":=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";

                  END;
        */

            end;
        }
        field(3969; "No. Series"; Code[60])
        {
        }
        field(3970; "No Series"; Code[50])
        {
        }
        field(3971; "Scheme No"; Code[10])
        {
            TableRelation = "HRM-Medical Schemes" WHERE(Status = FILTER(<> Closed));

            trigger OnValidate()
            begin
                // HRClaimTypes.GET("Claim Type");
                // HRClaimTypes.GET("Member No");
                // IF HRClaim."Claim Type" = HRClaimTypes."Scheme Type" THEN
                //     EXIT
                // ELSE
                //     ERROR('This scheme type is restricted to the ' + FORMAT(HRClaimTypes."Scheme Type") + ' Scheme Type');


                HRClaimTypes.Reset;
                HRClaimTypes.SetRange(HRClaimTypes."Scheme No", "Scheme No");
                if HRClaimTypes.Find('-') then begin
                    "Scheme Currency Code" := HRClaimTypes.Currency;
                    "Scheme Name" := HRClaimTypes."Scheme Name";
                end;

            end;
        }
        field(3972; "Member Names"; Text[150])
        {
        }
        field(3973; Status; enum "Custom Approval Status")
        {
        }
        field(3974; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(3975; "No Series."; Integer)
        {
            AutoIncrement = true;
        }
        field(3976; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Store Requisition,Employee Requisition,Leave Application,Transport Requisition,Training Requisition,Job Approval,Induction Approval,Disciplinary Approvals,Activity Approval,Exit Approval,Medical Claim Approval';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval";
        }
        field(3977; "Facility Name"; Text[50])
        {
        }
        field(3978; "Scheme Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(3979; "Scheme Amount Charged"; Decimal)
        {
        }
        field(3980; "Currency Factor"; Decimal)
        {

            trigger OnValidate()
            begin
                Curr.Reset;
                Curr.SetRange(Curr.Code, "Scheme Currency Code");
                if Curr.Find('-') then begin
                    "Currency Factor" := Curr."Currency Factor";
                end;
            end;
        }
        field(3981; "Claim Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        //Posted
        field(3982; "Posted"; Boolean)
        {
        }
        //PVNo
        field(3983; "PV No."; Code[20])
        {
        }
        field(3984; "Global Dimension 1 Code"; Code[30])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(3985; "Global Dimension 2 Code"; Code[30])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

        }
        field(3986; "Shortcut Dimension 3 Code"; Code[30])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the second Shortcut dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

        }
        //scheme name
        field(3987; "Scheme Name"; Text[150])
        {
        }
        //Patient type
        field(3988; "Patient Type"; Option)
        {
            OptionCaption = 'Self,Depedant';
            OptionMembers = Self,Depedant;
        }
        field(3989; "Batch No."; Code[20])
        {
            TableRelation = "Medical Claims Batch";
        }
        field(3990; "Inpatient Limit"; Decimal)
        {
            Caption = 'Inpatient Medical Limit';
            FieldClass = FlowField;
            CalcFormula = lookup("HRM-Job_Salary grade/steps"."Inpatient Medical Ceiling" where("Employee Category" = field("Employee Category"), "Salary Grade code" = field("Salary Grade")));
            Editable = false;
        }
        field(3991; "Outpatient Limit"; Decimal)
        {
            Caption = 'Outpatient Medical Limit';
            FieldClass = FlowField;
            CalcFormula = lookup("HRM-Job_Salary grade/steps"."Outpatient Medical Ceiling" where("Employee Category" = field("Employee Category"), "Salary Grade code" = field("Salary Grade")));
            Editable = false;
        }
        field(3992; "Optical Limit"; Decimal)
        {
            Caption = 'Optical Medical Limit';
            FieldClass = FlowField;
            CalcFormula = lookup("HRM-Job_Salary grade/steps"."Optical Medical Ceiling" where("Employee Category" = field("Employee Category"), "Salary Grade code" = field("Salary Grade")));
            Editable = false;
        }
        field(3993; "Employee Category"; Code[30])
        {
            Caption = 'Employee Category';
            FieldClass = FlowField;
            CalcFormula = lookup("HRM-Employee C"."Salary Category" where("No." = field("Member No")));
            Editable = false;
        }
        field(3994; "Salary Grade"; Code[30])
        {
            Caption = 'Salary Grade';
            FieldClass = FlowField;
            CalcFormula = lookup("HRM-Employee C"."Salary Grade" where("No." = field("Member No")));
            Editable = false;
        }
        field(3995; "Inpatient Running Balance"; Decimal)
        {
            Caption = 'Inpatient Running Balance';
            FieldClass = FlowField;
            CalcFormula = sum("HRM-Medical Claims"."Scheme Amount Charged" where("Member No" = field("Member No"), "Claim Type" = const(Inpatient), "Posted" = const(true), "Claim Date" = field("Date Filter")));
            Editable = false;
        }
        field(3996; "Outpatient Running Balance"; Decimal)
        {
            Caption = 'Outpatient Running Balance';
            FieldClass = FlowField;
            CalcFormula = sum("HRM-Medical Claims"."Scheme Amount Charged" where("Member No" = field("Member No"), "Claim Type" = const(Outpatient), "Posted" = const(true), "Claim Date" = field("Date Filter")));
            Editable = false;
        }
        field(3997; "Optical Running Balance"; Decimal)
        {
            Caption = 'Optical Running Balance';
            FieldClass = FlowField;
            CalcFormula = sum("HRM-Medical Claims"."Scheme Amount Charged" where("Member No" = field("Member No"), "Claim Type" = const(Optical), "Posted" = const(true), "Claim Date" = field("Date Filter")));
            Editable = false;
        }
        field(3998; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Member No", "Claim No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Claim No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Medical Claims Nos");
            NoSeriesMgt.InitSeries(HRSetup."Medical Claims Nos", xRec."No. Series", 0D, "Claim No", "No. Series");
        end;
        if "Member ID" = '' then begin
            "Member ID" := UserId;
        end;
        "Claim Date" := Today;


        // HREmp.Reset;
        // HREmp.SetRange(HREmp."User ID", "Member ID");
        // if HREmp.Find('-') then begin
        //     "Member No" := HREmp."No.";
        //     "Member Names" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        //     // "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
        //     // "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
        //     // "Shortcut Dimension 3 Code" := HREmp."Shortcut Dimension 3 Code";

        //     HRMSMembers.Reset;
        //     HRMSMembers.SetCurrentKey(HRMSMembers."Employee No");
        //     HRMSMembers.SetRange(HRMSMembers."Employee No", "Member No");
        //     if HRMSMembers.Find('-') then
        //         "Scheme No" := HRMSMembers."Scheme No";
        //     if MedicalSchemes.Find('-') then
        //         "Scheme Currency Code" := MedicalSchemes.Currency;
        // end;
    end;

    var
        MDependants: Record "HRM-Employee Kin";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "HRM-Setup";
        HRClaimTypes: Record "HRM-Medical Schemes";
        HRClaim: Record "HRM-Medical Claims";
        HREmp: Record "HRM-Employee C";
        Facility: Record "HRM-Medical Facility";
        Curr: Record Currency;
        HRMSMembers: Record "HRM-Medical Scheme Members";
        MedicalSchemes: Record "HRM-Medical Schemes";
        CurrExchRate: Record "Currency Exchange Rate";

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        //IF "Claim Currency Code"<> '' THEN BEGIN
        if "Claim Currency Code" <> "Scheme Currency Code" then begin
            CurrencyDate := "Claim Date";
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Claim Currency Code");
        end else
            "Currency Factor" := 0;
    end;

    procedure fnCheckCeilingAndBalance()
    var
        HrmSetup: Record "HRM-Setup";
        Grades: Record "HRM-Job_Salary grade/steps";
        Employee: Record "HRM-Employee C";
        Vendors: Record Vendor;
        Periods: Record "Accounting Period";
        StartDate: Date;
        EndDate: Date;
    begin
        Periods.Reset();
        Periods.SetRange("New Fiscal Year", true);
        if Periods.FindFirst() then
            StartDate := Periods."Starting Date";
        Periods.Reset();
        Periods.SetRange("New Fiscal Year", false);
        if Periods.FindLast() then
            EndDate := Periods."Starting Date";


        if Employee.get(rec."Member No") then begin
            Employee.TestField("Salary Category");
            Employee.TestField("Salary Grade");
            Grades.Reset();
            Grades.SetRange(Grades."Employee Category", Employee."Salary Category");
            Grades.SetRange("Salary Grade code", Employee."Salary Grade");
            if Grades.FindFirst() then begin
                case rec."Claim Type" of
                    rec."Claim Type"::Inpatient:
                        begin
                            Vendors.Reset();
                            Vendors.SetRange("No.", Employee."Vendor No.");
                            Vendors.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                            Vendors.SetRange("Transaction Type Filter", Vendors."Transaction Type Filter"::"Inpatient Claim");
                            if Vendors.FindFirst() then begin
                                Vendors.CalcFields("Medical Claim Balance");
                            end;
                            if Vendors."Medical Claim Balance" + rec."Claim Amount" > Grades."Inpatient Medical Ceiling" then
                                Error('Claim amount exceeds the inpatient medical ceiling');
                        end;
                    rec."Claim Type"::Outpatient:
                        begin
                            Vendors.Reset();
                            Vendors.SetRange("No.", Employee."Vendor No.");
                            Vendors.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                            Vendors.SetRange("Transaction Type Filter", Vendors."Transaction Type Filter"::"Outpatient Claim");
                            if Vendors.FindFirst() then begin
                                Vendors.CalcFields("Medical Claim Balance");
                            end;
                            if Vendors."Medical Claim Balance" + rec."Claim Amount" > Grades."Outpatient Medical Ceiling" then
                                Error('Claim amount exceeds the outpatient medical ceiling');
                        end;
                    rec."Claim Type"::Optical:
                        begin

                            Vendors.Reset();
                            Vendors.SetRange("No.", Employee."Vendor No.");
                            Vendors.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                            Vendors.SetRange("Transaction Type Filter", Vendors."Transaction Type Filter"::"Optical Claim");
                            if Vendors.FindFirst() then begin
                                Vendors.CalcFields("Medical Claim Balance");
                            end;
                            if Vendors."Medical Claim Balance" + rec."Claim Amount" > Grades."Optical Medical Ceiling" then
                                Error('Claim amount exceeds the optical medical ceiling');
                        end;
                end;
            end;

        end;
    end;

    procedure SetCurrentFiscalYearFilter()
    var
        Periods: Record "Accounting Period";
        StartDate: Date;
        EndDate: Date;
    begin
        Periods.Reset();
        Periods.SetRange("New Fiscal Year", true);
        if Periods.FindFirst() then
            StartDate := Periods."Starting Date";
        Periods.Reset();
        Periods.SetRange("New Fiscal Year", false);
        if Periods.FindLast() then
            EndDate := Periods."Starting Date";
        
        SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
    end;

    procedure GetAvailableBalance(ClaimType: Option Inpatient,Outpatient,Optical): Decimal
    var
        AvailableBalance: Decimal;
    begin
        SetCurrentFiscalYearFilter();
        CalcFields("Employee Category", "Salary Grade");
        
        case ClaimType of
            ClaimType::Inpatient:
                begin
                    CalcFields("Inpatient Limit", "Inpatient Running Balance");
                    AvailableBalance := "Inpatient Limit" - "Inpatient Running Balance";
                end;
            ClaimType::Outpatient:
                begin
                    CalcFields("Outpatient Limit", "Outpatient Running Balance");
                    AvailableBalance := "Outpatient Limit" - "Outpatient Running Balance";
                end;
            ClaimType::Optical:
                begin
                    CalcFields("Optical Limit", "Optical Running Balance");
                    AvailableBalance := "Optical Limit" - "Optical Running Balance";
                end;
        end;
        
        if AvailableBalance < 0 then
            AvailableBalance := 0;
            
        exit(AvailableBalance);
    end;

    procedure CheckForOverdraft()
    var
        AvailableBalance: Decimal;
        OverdraftMsg: Text;
        HMSSetup: Record "HMS-Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
    begin
        AvailableBalance := GetAvailableBalance("Claim Type");
        
        if AvailableBalance <= 0 then begin
            OverdraftMsg := 'ALERT: Employee %1 (%2) has exceeded their %3 medical limit. Available balance: %4';
            Message(OverdraftMsg, "Member Names", "Member No", Format("Claim Type"), AvailableBalance);
            
            // Send email alert to medical officer (using HMS Setup for medical officer email)
            if HMSSetup.Get() then
                if HMSSetup."Medical Officer Email" <> '' then
                    Recipients.Add(HMSSetup."Medical Officer Email");
            
            if Recipients.Count > 0 then begin
                Subject := 'Medical Claims Overdraft Alert';
                Body := StrSubstNo('Employee %1 (%2) has exceeded their %3 medical limit.\n\nAvailable Balance: %4\nEmployee Department: %5\nResponsibility Center: %6\n\nPlease review and take appropriate action.',
                    "Member Names", "Member No", Format("Claim Type"), AvailableBalance, "Global Dimension 2 Code", "Responsibility Center");
                EmailMessage.Create(Recipients, Subject, Body, true);
                if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
                    Message('Alert email sent to medical officers.');
            end;
        end;
    end;
}

