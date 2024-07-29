page 51032 "HRM-Appraisal Evaluation Areas"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Evaluation Areas";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                ShowCaption = false;
                field("Categorize As"; Rec."Categorize As")
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field("Sub Category"; Rec."Sub Category")
                {
                }
                field(Group; Rec.Group)
                {
                }
                field("Assign To"; Rec."Assign To")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Include in Evaluation Form"; Rec."Include in Evaluation Form")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

