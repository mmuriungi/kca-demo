page 51503 "REG-Files Listpart"
{
    ApplicationArea = All;
    Caption = 'REG-Files List';
    PageType = ListPart;
    Editable = false;
    SourceTable = "REG-Files";
    InsertAllowed = false;
    UsageCategory = Administration;
    CardPageId = "REG-Files Card";
    SourceTableView = where(Status = const(Open));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    ToolTip = 'Specifies the value of the File No. field.';
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the File Name field.';
                    ApplicationArea = All;
                }
                field("File Index"; Rec."File Index")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Section Number"; Rec."Section Number")
                {
                    Caption = 'Cabinet Number';
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    Caption = 'Cabinet Name';
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update File Index")
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                trigger OnAction()
                begin
                    Rec.updateRec();
                end;
            }
            action("Add File")
            {
                ApplicationArea = All;
                image = TestFile;
                trigger OnAction()
                var
                    files: Record "REG-Files";
                begin
                    files.Init();
                    files."File No." := 'File No.!';
                    files."Section Number" := Rec.GetFilter("Section Number");
                    files.Validate("Section Number");
                    files.Insert();
                    page.Run(Page::"REG-Files Card", files);
                end;
            }
        }
    }


}
