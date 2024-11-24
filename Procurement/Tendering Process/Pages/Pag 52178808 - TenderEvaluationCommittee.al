page 52178808 "Tender Evaluation Committee"
{
    PageType = List;
    SourceTable = "Tender Evaluation Committee";
    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("Tender No."; Rec."Tender No.")
                {
                    ToolTip = 'Specifies the value of the Tender No. field.';
                    ApplicationArea = All;
                }

                field("Employee no"; Rec."Employee no")
                {
                    ToolTip = 'Specifies the value of the Employee no field.';
                    ApplicationArea = All;
                }
                field("Employee name"; Rec."Employee name")
                {
                    ToolTip = 'Specifies the value of the Employee name field.';
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                    ApplicationArea = All;
                }
                field("Employee Cost Center"; Rec."Employee Cost Center")
                {
                    ToolTip = 'Specifies the value of the Employee Cost Center field.';
                    ApplicationArea = All;
                }
                field("Employee Region"; Rec."Employee Region")
                {
                    ToolTip = 'Specifies the value of the Employee Region field.';
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                }
                field(Active; Rec."Is Active")
                {
                    ToolTip = 'Specifies the value of the Active field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}