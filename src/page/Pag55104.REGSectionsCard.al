page 55104 "REG-Sections Card"
{
    Caption = 'File Cabinet Card';
    PageType = Card;
    SourceTable = Sections;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Number; Rec.Number)
                {
                    // Editable = cnumber;
                    ToolTip = 'Specifies the value of the Number field.';
                    ApplicationArea = All;
                    Caption = 'Cabinet Number';
                }
                field("Section Name"; Rec."Section Name")
                {
                    // Editable = cname;
                    ToolTip = 'Specifies the value of the Section Name field.';
                    Caption = 'Cabinet Name';
                    ApplicationArea = All;
                }
                field(Abbreviation; Rec.Abbreviation)
                {
                    //Editable = cabb;
                    ToolTip = 'Specifies the value of the Abbreviation field.';
                    ApplicationArea = All;
                }
            }
            group(Filess)
            {
                ShowCaption = false;
                part(lines; "REG-Files Listpart")
                {
                    ApplicationArea = All;
                    SubPageLink = "Section Number" = field(Number);
                }

            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Files")
            {
                Visible = false;
                ApplicationArea = All;
                Image = Filed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "REG-Files List";
                RunPageLink = "Section Number" = field(Number);
            }
            action("Add File")
            {
                //   Visible = false;
                ApplicationArea = All;
                image = AuthorizeCreditCard;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.AddFile();
                end;
            }
        }
    }
    var
        cnumber: Boolean;
        cname: Boolean;
        cabb: Boolean;

    trigger OnOpenPage()
    begin
        Editability();
    end;


    procedure Editability()
    begin
        cnumber := false;
        cname := false;
        cabb := false;

        If Rec.number = '' then
            cnumber := true;
        if Rec."Section Name" = '' then
            cname := true;

        if Rec.Abbreviation = '' then
            cabb := true;

    end;
}
