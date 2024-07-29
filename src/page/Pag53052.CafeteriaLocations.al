page 53052 "Cafeteria Locations"
{
    PageType = List;
    SourceTable = Location;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Cafeteria Location"; Rec."Cafeteria Location")
                {
                }
                field("Campus Code"; Rec."Campus Code")
                {
                }
                field("Cafeteria Location Category"; Rec."Cafeteria Location Category")
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
        Rec.SETFILTER("Cafeteria Location", '=%1', TRUE);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Cafeteria Location" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Cafeteria Location" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Cafeteria Location", '=%1', TRUE);
    end;
}

