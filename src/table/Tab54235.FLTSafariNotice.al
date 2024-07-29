table 54235 "FLT-Safari Notice"
{

    fields
    {
        field(1; "Safari No."; Code[10])
        {
        }
        field(2; "Proposed By"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                hrman2.Reset;
                hrman2.SetRange(hrman2."No.", "Proposed By");
                if hrman2.Find('-') then begin
                    "Proposer Name" := hrman2."First Name" + ' ' + hrman2."Middle Name" + ' ' + hrman2."Last Name";
                end;
            end;
        }
        field(3; "Proposer Name"; Text[50])
        {
        }
        field(4; "Proposer Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(5; "Proposed Date"; Date)
        {
        }
        field(6; "Officer Going"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                hrman.Reset;
                hrman.SetRange(hrman."No.", "Officer Going");
                if hrman.Find('-') then begin
                    "Officer Designation" := hrman.Initials;
                    "Officer Going Name" := hrman."First Name" + ' ' + hrman."Middle Name" + ' ' + hrman."Last Name";
                    "Officer Going PIF No" := hrman."No.";
                end;
                usersetup.Reset;
                //usersetup.SetRange(usersetup."Employee No.","Officer Going");
                if usersetup.Find('-') then begin
                    "Officer On Safari ID" := usersetup."User ID";
                end else
                    Error('The officer ' + hrman."First Name" + ' ' + hrman."Middle Name" + ' ' + hrman."Last Name"
           + ' has not been setup as a system user.Consult the system Administrator.');
                Modify;
            end;
        }
        field(7; "Officer Going Name"; Text[50])
        {
        }
        field(8; "Officer Designation"; Code[20])
        {
        }
        field(9; "Purpose Of Visit"; Text[250])
        {
        }
        field(10; "Place to Visit"; Text[50])
        {
        }
        field(11; "Departure Date"; Date)
        {
        }
        field(12; "Return Date"; Date)
        {
        }
        field(13; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Submitted,approved;
        }
        field(14; "Departure Mileage"; Decimal)
        {
        }
        field(15; "Reg. No"; Text[30])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
        }
        field(16; Make; Text[30])
        {
        }
        field(17; Type; Text[30])
        {
        }
        field(18; "Estimated Cost of Safari"; Decimal)
        {
        }
        field(19; Dept; Code[10])
        {
        }
        field(20; "T.O. Name"; Text[30])
        {
        }
        field(21; "T.O. Approval Date"; Date)
        {
        }
        field(22; "HRM Name"; Text[30])
        {
        }
        field(23; "HRM Approval Date"; Date)
        {
        }
        field(24; "Finance Officer Name"; Text[30])
        {
        }
        field(25; "Finance Officer Approval Date"; Date)
        {
        }
        field(26; "Director Name"; Text[30])
        {
        }
        field(27; "Director Approval Date"; Date)
        {
        }
        field(28; "Dep. Director"; Text[150])
        {
        }
        field(29; "Dep. Director Approval Date"; Date)
        {
        }
        field(32; "No. Series"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(33; "Finance Funds Availability"; Text[250])
        {
        }
        field(34; "User Id"; Code[20])
        {
        }
        field(50000; "TO ID"; Code[20])
        {
        }
        field(50001; "Department Name"; Text[100])
        {
        }
        field(50002; "Officer On Safari ID"; Code[20])
        {
        }
        field(50003; "Officer Going PIF No"; Code[20])
        {
        }
        field(50005; "HRM ID"; Code[20])
        {
        }
        field(50006; "FO ID"; Code[20])
        {
        }
        field(50008; "Director ID"; Code[20])
        {
        }
        field(50009; Makes; Code[10])
        {
            CalcFormula = Lookup("FLT-Vehicle Header".Make WHERE("Registration No." = FIELD("Reg. No")));
            FieldClass = FlowField;
            TableRelation = "FLT-Make".Code;
        }
        field(50010; Model; Code[10])
        {
            CalcFormula = Lookup("FLT-Vehicle Header".Model WHERE("Registration No." = FIELD("Reg. No")));
            FieldClass = FlowField;
            TableRelation = "FLT-Flt Model".Code;
        }
        field(50011; "Dep. Director ID"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Safari No.", "Reg. No")
        {
        }
    }

    fieldgroups
    {
    }


    trigger OnInsert()
    begin

        FltMgtSetup.Get;
        FltMgtSetup.TestField(FltMgtSetup."Fuel Payment Batch No");
        NoSeriesMgt.InitSeries(FltMgtSetup."Fuel Payment Batch No", xRec."No. Series", 0D, "Safari No.", "No. Series");
        // if Type = Type::Fuel then begin
        //     if "Requisition No" = '' then begin
        //         FltMgtSetup.Get;
        //         FltMgtSetup.TestField(FltMgtSetup."Fuel Register");
        //         NoSeriesMgt.InitSeries(FltMgtSetup."Fuel Register", xRec."No. Series", 0D, "Requisition No", "No. Series");
        //     end;
        // end else begin
        //     if Type = Type::Maintenance then begin
        //         if "Requisition No" = '' then begin
        //             FltMgtSetup.Get;
        //             FltMgtSetup.TestField(FltMgtSetup."Maintenance Request");
        //             NoSeriesMgt.InitSeries(FltMgtSetup."Maintenance Request", xRec."No. Series", 0D, "Requisition No", "No. Series");
        //         end;
        //     end;
        // end;
    end;


    var
        FltMgtSetup: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Record "General Ledger Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        SafariReq: Record "FLT-Safari Notice";
        usersetup: Record "User Setup";
        hrman: Record "HRM-Employee C";
        hrman2: Record "HRM-Employee C";
        usersetup2: Record "User Setup";
}

