page 51039 "Aca-Charge Addition Lines"
{
    PageType = ListPart;
    SourceTable = "Aca-Charge Addition Lines";
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stage field.';
                }
                field("Charge Code"; Rec."Charge Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Code field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.';
                }
                field("Income Account"; Rec."Income Account")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Income Account field.';
                }
                field(Priority; Rec.Priority)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Priority field.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field(Term; Rec.Semester)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Term field.';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reg. Transacton ID field.';
                }
            } 
        }
    }

    actions
    {
        area(Processing)
        {
            action(ExportKUCCPSTemplate)
            {
                Caption = 'Export Student Charges';
                Image = ExportFile;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Report.Run(Report::"Export Charge Additions");
                end;
            }
            action(Import)
                {
                    Caption = 'Import Student Charges';
                    Image = ExportFile;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Import Student Charges', true) = false then exit;
                        Xmlport.Run(XmlPort::"Import Charge Additions", false, true);
                    end;
                }
        }
    }
}