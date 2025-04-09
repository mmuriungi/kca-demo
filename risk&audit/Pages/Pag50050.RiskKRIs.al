page 50222 "Risk KRI(s)"
{
    PageType = ListPart;
    SourceTable = "Risk Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field(Type; Type)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                // }

                field(KRI; Rec.KRI)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Tolerance; Rec.Tolerance)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Appetite; Rec.Appetite)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Update Frequency"; Rec."Update Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
    }
}

