#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
xmlport 50010 "Import Charge Additions"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Charge Addition"; "Aca-Charge Addition Lines")
            {
                AutoUpdate = false;
                XmlName = 'Item';
                fieldelement(a; "Charge Addition"."Student No.")
                {
                }
                fieldelement(b; "Charge Addition"."Student Name")
                {
                }
                fieldelement(c; "Charge Addition".Stage)
                {
                }
                fieldelement(d; "Charge Addition"."Charge Code")
                {
                }
                fieldelement(e; "Charge Addition".Amount)
                {
                }
                fieldelement(f; "Charge Addition"."Academic Year")
                {
                }
                fieldelement(g; "Charge Addition".Semester)
                {
                    
                }
                trigger OnAfterInitRecord()
                begin
                    if captionRow then begin
                        captionRow := false;
                        currXMLport.Skip();
                    end;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
    trigger OnPreXmlPort()
    begin
        captionRow := true;
    end;

    var
        captionRow: Boolean;
}