page 50435 "HRM-Intern&Attach List"
{
    CardPageID = "HRM-Intern&Attach  Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Internships&Attachments";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                }
                field(Institution; Rec.Institution)
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field("Ref No"; Rec."Ref No")
                {
                }
                field("Year Of Study"; Rec."Year Of Study")
                {
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                }
                field(Age; Rec.Age)
                {
                }
                field(Course; Rec.Course)
                {
                }
                field(Department; Rec.Department)
                {
                }
                field(Period; Rec.Period)
                {
                }
                field(Renewable; Rec.Renewable)
                {
                }
                field(Paid; Rec.Paid)
                {
                }
                field(Disability; Rec.Disability)
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Attachment Letter")
            {
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Category4;
                //RunObject = Report 68634;
            }
            action("Memo Letter")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category4;
                // RunObject = Report 68635;
            }
            action("Internship Letter")
            {
                Image = CashFlow;
                Promoted = true;
                PromotedCategory = Category4;
                //RunObject = Report 68636;
            }
            action("Recommendation Letter")
            {
                Image = RollUpCosts;
                Promoted = true;
                PromotedCategory = Category4;
                //RunObject = Report 68637;
            }
        }
    }
}

