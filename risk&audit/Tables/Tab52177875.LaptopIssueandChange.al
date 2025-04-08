table 50137 "Laptop Issue and Change"
{
    Caption = 'Laptop Issue and Change';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            // trigger Onvalidate()
            // begin
            //     if "No." <> xRec."No." then
            //         NoSeriesMgt.TestManual(ICTSetup."Property Issue  Nos");
            // end;
        }
        field(2; "Employee No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                if Emp.Get("Employee No.") then begin
                    "Employe Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Requested by department" := Emp."Global Dimension 1 Code";
                end;
            end;
        }
        field(3; "Employe Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Assign Asset"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Comment on Property"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Approver ID"; Code[100])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Approver Confirm Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "ICT Manager Review"; Text[1050])
        {
            Caption = 'Professional Opinion on impact of the change to the Business';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "ICT Manager Review Date" := Today;
                "ICT Manager Review ID" := UserId;
            end;
        }
        field(9; "ICT Manager Review Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Manager ICT"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Approve,Reject,Defer;
            OptionCaption = ' ,Approve for Implementation, reject, Defer Until';
            trigger OnValidate()
            begin
                "Manager ICT Review Date" := Today;
                "Manger ICT Confirm Review ID" := UserId;
                if "Manager ICT" <> "Manager ICT"::Defer then
                    "Defer until date" := 0D;
            end;
        }
        field(11; "Manager ICT Review Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "CEO Approval"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Approved,Rejected;
            trigger OnValidate()
            begin
                "CEO Approval Date" := Today;
                "CEO ID" := UserId;
            end;
        }
        field(13; "CEO Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "CEO ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Manger ICT Confirm Review ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "ICT Manager Review ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Issue,Change;
        }
        field(19; "Defer until date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Reason; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Impact of change"; Blob)
        {
            Caption = 'Impact of implementing proposed change';
            DataClassification = ToBeClassified;
        }

        field(22; "Date of request"; Date)
        {
            Caption = 'Date of request';
            DataClassification = ToBeClassified;
        }
        field(23; "Requested by department"; Code[30])
        {
            Caption = 'Requested by department';
            DataClassification = ToBeClassified;
        }
        field(24; "Proposed Change Description"; Blob)
        {
            Caption = 'Proposed Change Description';
            DataClassification = ToBeClassified;
        }
        field(25; Priority; Option)
        {
            Caption = 'Priority';
            DataClassification = ToBeClassified;
            OptionMembers = " ",High,Medium,Low;
            OptionCaption = ' ,High,Medium,Low';
        }
        field(26; "Nature of Change"; Option)
        {
            Caption = 'Nature of Change';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Scheduled,Unscheduled,Emergency;
            OptionCaption = ' ,Scheduled,Unscheduled,Emergency';
        }
        field(27; "Proposed Date"; Date)
        {
            Caption = 'Proposed Date';
            DataClassification = ToBeClassified;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                Validate("End Date");
            end;
        }
        field(28; "Proposed Time"; Time)
        {
            Caption = 'Proposed Time';
            DataClassification = ToBeClassified;
        }
        field(29; "Estimated Duration"; DateFormula)
        {
            Caption = 'Estimated Duration';
            DataClassification = ToBeClassified;
        }
        field(30; Justification; Blob)
        {
            Caption = 'Justification';
            DataClassification = ToBeClassified;
        }
        field(31; "Current Laptop"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";
            trigger Onvalidate()
            var
                FA: Record "Fixed Asset";
            begin
                if FA.Get("Current Laptop") then
                    "Current Laptop description" := FA.Description;
            end;
        }
        field(32; "Current Laptop description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Laptop to issue"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";
            trigger Onvalidate()
            var
                FA: Record "Fixed Asset";
            begin
                if FA.Get("Laptop to issue") then
                    "Laptop description" := FA.Description;
            end;
        }
        field(34; "Laptop description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(35; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; Approve; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Approver ID" := UserId;
                "Approver Confirm Receipt Date" := Today;
            end;
        }
        field(38; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ("Proposed Date" <> 0D) and ("End Date" <> 0D) then
                    if "End Date" < "Proposed Date" then
                        Error('Start date cannot be greater than end date');
            end;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        ICTSetup.Get();
        Case Type of
            Type::Change:
                begin
                    ICTSetup.TestField("Change Request  Nos");
                    NoSeriesMgt.InitSeries(ICTSetup."Change Request  Nos", xRec."No. Series", Today, "No.", "No. Series");
                end;
            Type::Issue:
                begin
                    ICTSetup.TestField("Laptop Issue  Nos");
                    NoSeriesMgt.InitSeries(ICTSetup."Laptop Issue  Nos", xRec."No. Series", Today, "No.", "No. Series");
                end;
        end;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then
            "Employee No." := UserSetup."Employee No.";
        Validate("Employee No.");
        "Date of request" := Today;

    end;

    var
        ICTSetup: Record "ICT Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";

}
