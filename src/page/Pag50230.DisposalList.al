page 50230 "Disposal List"
{
    CardPageID = "Disposal Plan";
    Editable = false;
    PageType = List;
    SourceTable = "Disposal Plan Table Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Year; Rec.Year)
                {
                }
                field(Description; Rec.Description)
                {
                    Visible = false;
                }
                field("Disposal Year"; Rec."Disposal Year")
                {
                }
                field("Disposal Description"; Rec."Disposal Description")
                {
                }
                field("Disposal Method"; Rec."Disposal Method")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Planned Date"; Rec."Planned Date")
                {
                    Visible = false;
                }
                field("Shortcut dimension 1 code"; Rec."Shortcut dimension 1 code")
                {
                    Caption = 'Department Code';
                }
                field("Shortcut dimension 2 code"; Rec."Shortcut dimension 2 code")
                {
                    Caption = 'County Code';
                }
                field(Status; Rec.Status)
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
            }
        }
    }

    actions
    {
    }
}

