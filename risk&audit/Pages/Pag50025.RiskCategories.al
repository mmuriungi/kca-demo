page 50025 "Risk Categories"
{
    PageType = List;
    SourceTable = "Risk Categories";
    SourceTableView = where(Type = const(Category));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Category;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Category;
    end;
}

