page 50751 "Lecturer Units List"
{
    PageType = List;
    SourceTable = "ACA-Lecturers Units";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Engagement Terms"; Rec."Engagement Terms")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Group Type"; Rec."Group Type")
                {
                    ApplicationArea = All;
                }
                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field("No. Of Hours"; Rec."No. Of Hours")
                {
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Posted On"; Rec."Posted On")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Registered Students"; Rec."Registered Students")
                {
                    ApplicationArea = All;
                }
                field("Available From"; Rec."Available From")
                {
                    ApplicationArea = All;
                }
                field("Available To"; Rec."Available To")
                {
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                }
                field("Marks Submitted"; Rec."Marks Submitted")
                {
                    ApplicationArea = All;
                }
                field("Required Equipment";Rec."Required Equipment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

