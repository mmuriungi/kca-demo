page 52079 "Medical Schemes"
{
    ApplicationArea = All;
    Caption = 'Medical Schemes';
    PageType = List;
    SourceTable = "HRM-Medical Schemes";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Scheme No"; Rec."Scheme No")
                {
                    ToolTip = 'Specifies the value of the Scheme No field.', Comment = '%';
                }
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ToolTip = 'Specifies the value of the Scheme Name field.', Comment = '%';
                }
                field("Scheme Type"; Rec."Scheme Type")
                {
                    ToolTip = 'Specifies the value of the Scheme Type field.', Comment = '%';
                }
                field("Medical Insurer"; Rec."Medical Insurer")
                {
                    ToolTip = 'Specifies the value of the Medical Insurer field.', Comment = '%';
                }
                field("Insurer Name"; Rec."Insurer Name")
                {
                    ToolTip = 'Specifies the value of the Insurer Name field.', Comment = '%';
                }
                field("Maximum No of Dependants"; Rec."Maximum No of Dependants")
                {
                    ToolTip = 'Specifies the value of the Maximum No of Dependants field.', Comment = '%';
                }
                field("Scheme Members"; Rec."Scheme Members")
                {
                    ToolTip = 'Specifies the value of the Scheme Members field.', Comment = '%';
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("Out-patient limit"; Rec."Out-patient limit")
                {
                    ToolTip = 'Specifies the value of the Out-patient limit field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("In-patient limit"; Rec."In-patient limit")
                {
                    ToolTip = 'Specifies the value of the In-patient limit field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field("Dependants Included"; Rec."Dependants Included")
                {
                    ToolTip = 'Specifies the value of the Dependants Included field.', Comment = '%';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field("Area Covered"; Rec."Area Covered")
                {
                    ToolTip = 'Specifies the value of the Area Covered field.', Comment = '%';
                }
            }
        }
    }
}
