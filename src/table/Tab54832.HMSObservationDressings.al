table 54832 "HMS-Observation Dressings"
{

    fields
    {
        field(1; "Observation No."; Code[20])
        {
        }
        field(2; "Process No."; Code[20])
        {
          
        }
        field(3; Description; text[250])
        {
            
        }
        field(4; "Item No."; Code[20])
        {
            TableRelation = Item."No." where("Inventory Posting Group" = filter('Medicine'));
            trigger OnValidate()
            begin
                item.reset();
               if item.get("Item No.") then
               rec."Item Description":= item.Description;
               rec.Quantity:=item.Inventory;
                 

            end;
        }
        field(5; "Item Description"; Text[100])
        {
         
        }
        field(6; "Unit of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(7; Quantity; Decimal)
        {
            
        }
        field(8; Remarks; Text[200])
        {
        }
        field(9; Posted; Boolean)
        {
        }
        

    }
   
    

    keys
    {
        key(Key1; "Observation No.", "Process No.", "Item No.")
        {
            Clustered = true;
        }
    }
    

    fieldgroups
    {
    }
    var
    item: Record item;
}

