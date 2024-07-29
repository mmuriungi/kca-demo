page 51078 "HRM-Stage Requirement Lines"
{
    PageType = List;
    SourceTable = "HRM-Stage Requirements";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Stage Code"; Rec."Stage Code")
                {
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                    Importance = Promoted;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    Importance = Promoted;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Grade Attained"; Rec."Grade Attained")
                {
                }
                field(Priority; Rec.Priority)
                {
                }
                field("Desired Score"; Rec."Desired Score")
                {
                }
                field("Total (Stage)Desired Score"; Rec."Total (Stage)Desired Score")
                {
                    Visible = false;
                }
                field(Mandatory; Rec.Mandatory)
                {
                }
            }
        }
    }

    actions
    {
    }
}

