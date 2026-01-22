page 50278 "Audit Workpaper Scope"
{
    PageType = ListPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Scope Line No."; Rec."Scope Line No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}