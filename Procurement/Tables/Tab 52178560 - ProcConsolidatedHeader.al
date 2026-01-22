table 52178560 "Proc Consolidated Header"
{
    Caption = 'Proc Consolidated Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Fy; Code[50])
        {
            Caption = 'Fy';

            TableRelation = "Proc Plan Periods".Fy where(Current = filter(true));
            trigger OnValidate()
            begin
                Active := true;
                Description := 'Consolidated Plan for the Financial Year' + ' ' + Fy;
                Date := Today;
                "Created By" := UserId;
            end;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(5; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            CalcFormula = sum("Proc Consolidated Lines".Amount where(Fy = field(fy)));
            FieldClass = FlowField;
            Editable = false;
        }
    }
    keys
    {
        key(PK; Fy)
        {
            Clustered = true;
        }
    }
    procedure ConsolidatePlan()
    begin
        ConsoLines.Reset();
        ConsoLines.SetRange(Fy, rec.Fy);
        if ConsoLines.Find('-') then begin
            ConsoLines."1st Quater" := 0;
            ConsoLines."2nd Quater" := 0;
            ConsoLines."3rd Quater" := 0;
            ConsoLines."4th Quater" := 0;
            ConsoLines.Modify();

        end;

        DireplanHeader.Reset();
        DireplanHeader.SetRange("Budget Name", rec.Fy);
        DireplanHeader.SetRange(Status, DireplanHeader.Status::Approved);
        if DireplanHeader.Find('-') then begin
            DirePlanLines.Reset();
            DirePlanLines.SetRange("Budget Name", DireplanHeader."Budget Name");
            if DirePlanLines.Find('-') then begin
                repeat
                    ConsoLines.Reset();
                    ConsoLines.SetRange(Fy, DirePlanLines."Budget Name");
                    ConsoLines.SetRange(No, DirePlanLines."No.");
                    ConsoLines.SetRange(Type, DirePlanLines.Type);
                    if not ConsoLines.FindSet() then begin
                        ConsoLines.Init();
                        ConsoLines.Fy := DirePlanLines."Budget Name";
                        ConsoLines.No := DirePlanLines."No.";
                        ConsoLines.Type := DirePlanLines.Type;
                        ConsoLines.Description := DirePlanLines.Description;
                        ConsoLines."Votebook Account" := DirePlanLines."Votebook Account";
                        ConsoLines."Unit Of Measure" := DirePlanLines."Unit Of Measure";
                        ConsoLines."Unit Cost" := DirePlanLines."Unit Cost";
                        ConsoLines.Insert();
                    end;
                    ConsoLines.Reset();
                    ConsoLines.SetRange(Fy, DirePlanLines."Budget Name");
                    ConsoLines.SetRange(No, DirePlanLines."No.");
                    ConsoLines.SetRange(Type, DirePlanLines.Type);
                    if ConsoLines.FindSet() then begin
                        ConsoLines.Fy := DirePlanLines."Budget Name";
                        ConsoLines.No := DirePlanLines."No.";
                        ConsoLines.Type := DirePlanLines.Type;
                        ConsoLines.Description := DirePlanLines.Description;
                        ConsoLines."Votebook Account" := DirePlanLines."Votebook Account";
                        ConsoLines."Unit Of Measure" := DirePlanLines."Unit Of Measure";
                        ConsoLines."Unit Cost" := DirePlanLines."Unit Cost";
                        ConsoLines.modify();
                    end;
                until DirePlanLines.Next() = 0;
            end;
            Message('Plan for the year %1 has been consolidated', rec.Fy);
        end;

    end;


    var
        DireplanHeader: Record "PROC-Procurement Plan Header";
        DirePlanLines: Record "PROC-Procurement Plan Lines";
        ConsoHeader: Record "Proc Consolidated Header";
        ConsoLines: Record "Proc Consolidated Lines";
}
