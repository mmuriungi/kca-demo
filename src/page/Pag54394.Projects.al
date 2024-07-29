page 54394 Projects
{
    Caption = 'Projects';
    PageType = List;
    SourceTable = Project;
    CardPageId = Project;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Project Type"; Rec."Project Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Type field.';
                }
                field("Contract Summary"; Rec."Contract Summary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Summary field.';
                }
                field("Perfomance Bond"; Rec."Perfomance Bond")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Perfomance Bond field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("Expected End Date"; Rec."Expected End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected End Date field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created by field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;
}
