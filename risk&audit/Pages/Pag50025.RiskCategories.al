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
                field("Code"; Code)
                {
                    Caption = 'Code';
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Description)
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
        Type := Type::Category;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::Category;
    end;
}

