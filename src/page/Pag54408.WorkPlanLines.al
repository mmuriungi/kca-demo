page 54408 "WorkPlan Lines"
{
    Caption = 'WorkPlan Lines';
    PageType = ListPart;
    SourceTable = "Work Plan Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("S/No."; Rec."S/No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the S/No. field.';
                }
                field("Description"; Rec."Performance Criteria")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Performance Criteria field.';
                }
                field("Category Code"; Rec."Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field.';
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Category Description field.';
                }

                // field("Unit of Measure"; Rec."Unit of Measure")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     ToolTip = 'Specifies the value of the Unit of Measure field.';
                // }
                // field("Weight (%)"; Rec."Weight (%)")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     ToolTip = 'Specifies the value of the Weight (%) field.';
                // }
                /* field("Target (FY 2021/22)"; Rec."Target (FY 2021/22)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Target (FY 2021/22) field.';
                } */
                // field(Category; Rec.Category)
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     ToolTip = 'Specifies the value of the Category field.';
                // }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            // group("Batch Upload")
            // {
            //     action(ExportToExcel)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Export To Excel';
            //         Image = ExportToExcel;


            //         trigger OnAction()
            //         begin
            //             Utils.ExportCashReqLineTemplate(Rec);
            //         end;
            //     }
            //     action(ImportFromExcel)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import From Excel';
            //         Image = ImportExcel;


            //         trigger OnAction()
            //         begin
            //             Utils.ReadFromExcel();
            //             Utils.ImportExcelData();
            //         end;
            //     }
            // }
        }
    }
    var
    // Utils: Codeunit utils;
}
