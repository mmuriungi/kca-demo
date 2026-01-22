page 52078 "Medical Scheme Members"
{
    ApplicationArea = All;
    Caption = 'Medical Scheme Members';
    PageType = List;
    SourceTable = "HRM-Medical Scheme Members";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.', Comment = '%';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
                }
                field("Maximum Cover"; Rec."Maximum Cover")
                {
                    ToolTip = 'Specifies the value of the Maximum Cover field.', Comment = '%';
                }
                field("Maximum No of dependants"; Rec."Maximum No of dependants")
                {
                    ToolTip = 'Specifies the value of the Maximum No of dependants field.', Comment = '%';
                }
                field("No of Depnedants"; Rec."No of Depnedants")
                {
                    ToolTip = 'Specifies the value of the No of Depnedants field.', Comment = '%';
                }
                field("Scheme No"; Rec."Scheme No")
                {
                    ToolTip = 'Specifies the value of the Scheme No field.', Comment = '%';
                }
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ToolTip = 'Specifies the value of the Scheme Name field.', Comment = '%';
                }
                field("Scheme Join Date"; Rec."Scheme Join Date")
                {
                    ToolTip = 'Specifies the value of the Scheme Join Date field.', Comment = '%';
                }
                field("Scheme Anniversary"; Rec."Scheme Anniversary")
                {
                    ToolTip = 'Specifies the value of the Scheme Anniversary field.', Comment = '%';
                }
                field("Out-Patient Limit"; Rec."Out-Patient Limit")
                {
                    ToolTip = 'Specifies the value of the Out-Patient Limit field.', Comment = '%';
                }
                field("In-patient Limit"; Rec."In-patient Limit")
                {
                    ToolTip = 'Specifies the value of the In-patient Limit field.', Comment = '%';
                }
                field("Cumm.Amount Spent Out"; Rec."Cumm.Amount Spent Out")
                {
                    ToolTip = 'Specifies the value of the Cumm.Amount Spent Out field.', Comment = '%';
                }
                field("Cumm.Amount Spent"; Rec."Cumm.Amount Spent")
                {
                    ToolTip = 'Specifies the value of the Cumm.Amount Spent field.', Comment = '%';
                }
                field("Balance Out- Patient"; Rec."Balance Out- Patient")
                {
                    ToolTip = 'Specifies the value of the Balance Out- Patient field.', Comment = '%';
                }
                field("Balance In- Patient"; Rec."Balance In- Patient")
                {
                    ToolTip = 'Specifies the value of the Balance In- Patient field.', Comment = '%';
                }
            }
        }
    }
}
