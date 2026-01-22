page 50156 "Workplan List"
{
    CardPageID = "Workplan Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    SourceTable = Workplan;
    SourceTableView = WHERE("Last Year" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Workplan Code"; Rec."Workplan Code")
                {
                }
                field("Workplan Description"; Rec."Workplan Description")
                {
                    Caption = 'Workplan Description';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Outlook; Outlook)
            {
            }
            systempart(Notes; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Visible = false;
                action("Workplan Activities")
                {
                    Caption = 'Workplan Activities';
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Workplan Activities";
                    RunPageLink = "Workplan Code" = FIELD("Workplan Code");
                    RunPageMode = Edit;
                }
                action(Print)
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Rec.RESET;
                        Rec.SETFILTER("Workplan Code", Rec."Workplan Code");
                        REPORT.RUN(70023, TRUE, TRUE, Rec);
                        Rec.RESET;

                    end;
                }
            }
        }
    }
}

