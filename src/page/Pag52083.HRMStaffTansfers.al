page 52085 "HRM-Staff Tansfers"
{
    ApplicationArea = All;
    Caption = 'HRM-Staff Tansfers';
    PageType = List;
    SourceTable = "HRM-Staff Tansfer";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field.', Comment = '%';
                }
                field("Type of transfer"; Rec."Type of transfer")
                {
                    ToolTip = 'Specifies the value of the Type of transfer field.', Comment = '%';
                }
                field("Previous Office"; Rec."Previous Office")
                {
                    ToolTip = 'Specifies the value of the Previous Office field.', Comment = '%';
                }
                field("Previous Designation"; Rec."Previous Designation")
                {
                    ToolTip = 'Specifies the value of the Previous Designation field.', Comment = '%';
                }
                field("Current Office"; Rec."Current Office")
                {
                    ToolTip = 'Specifies the value of the Current Office field.', Comment = '%';
                }
                field("Current Designition"; Rec."Current Designition")
                {
                    ToolTip = 'Specifies the value of the Current Designition field.', Comment = '%';
                }
                field("Reason for Transfer/Deployment"; Rec."Reason for Transfer/Deployment")
                {
                    ToolTip = 'Specifies the value of the Reason for Transfer/Deployment field.', Comment = '%';
                }
                field("Payable Allowances"; Rec."Payable Allowances")
                {
                    ToolTip = 'Specifies the value of the Payable Allowances field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
            }
        }
    }
    actions
    {

    }
}
