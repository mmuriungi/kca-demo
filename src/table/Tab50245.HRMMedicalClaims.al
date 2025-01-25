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
                end;
            end;
        }
        field(2; "Claim Type"; Option)
        {
            OptionMembers = Inpatient,Outpatient;
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
            TableRelation = "HRM-Employee Kin"."Other Names" WHERE("Employee Code" = FIELD("Member No"));

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
        "Member ID" := UserId;
        "Member No" := HREmp."No.";
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
}

