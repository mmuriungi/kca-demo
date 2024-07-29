page 54432 "Departmental Activities1"
{
    Caption = 'Departmental Activities1';
    PageType = ListPart;
    SourceTable = "Dept Activities";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target field.';
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field.';
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Description field.';
                }
            }
        }
    }
    // actions
    // {
    //     // area(Processing)
    //     // {
    //     //     group("Batch Upload")
    //     //     {
    //     //         // action(ExportToExcel)
    //     //         // {
    //     //         //     ApplicationArea = All;
    //     //         //     Caption = 'Export To Excel';
    //     //         //     Image = ExportToExcel;


    //     //         //     trigger OnAction()
    //     //         //     begin
    //     //         //         Utils.ExportCashReqLineTemplate(Rec);
    //     //         //     end;
    //     //         }
    //     //         action(ImportFromExcel)
    //     //         {
    //     //             ApplicationArea = All;
    //     //             Caption = 'Import From Excel';
    //     //             Image = ImportExcel;


    //     //             trigger OnAction()
    //     //             begin
    //     //                 Utils.ReadFromExcel();
    //     //                 Utils.ImportExcelData();
    //     //             end;
    //     //         }
    //      }
    //     }
    // var
    //     Utils: Codeunit utils;
}

