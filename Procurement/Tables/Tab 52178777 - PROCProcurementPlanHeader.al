table 52178777 "PROC-Procurement Plan Header"
{
    DrillDownPageID = "PROC-Procurement Plan list";
    LookupPageID = "PROC-Procurement Plan list";

    fields
    {
        field(1; "Budget Name"; Code[20])
        {
            TableRelation = "Proc Plan Periods".Fy where(closed = filter(false));
            trigger OnValidate()
            begin

                Name := 'Procurement Plan for the Financial Year' + ' ' + "Budget Name";
            end;

        }
        field(2; "Active"; Boolean)
        {
            Editable = false;

        }
        field(3; "Budgeted Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("PROC-Procurement Plan Lines".Amount where("Budget Name" = field("Budget Name"), "Global Dimension 1 Code" = field("Global Dimension 1 Code")));
        }
        field(4; "Name"; Text[100])
        {

        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }
        field(7; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
        }
        field(8; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
        }
        field(9; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved,Consolidated,Rejected;
            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    procLines.Reset();
                    procLines.SetRange("Budget Name", rec."Budget Name");
                    procLines.SetRange("Global Dimension 1 Code", rec."Global Dimension 1 Code");
                    procLines.SetRange(Approved, false);
                    if procLines.Find('-') then begin
                        repeat
                            procLines.Approved := true;
                            procLines.Modify();
                        until procLines.Next() = 0;
                    end;
                end;
            end;
        }
        field(10; Date; Date)
        {
            Editable = false;
        }
        field(11; "Created By"; Code[50])
        {
            Editable = false;
        }



    }


    keys
    {
        key(Key1; "Budget Name", "Global Dimension 1 Code")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin
        Active := true;
        "Created By" := UserId;
        Date := today;
    end;

    var
        procLines: Record "PROC-Procurement Plan Lines";


}

