public with sharing class PageStyleHandler {

    public String strColor{get;set;}
    public String strFontFamily{get;set;}
    public String strFontweight{get;set;}
    public String strStyleString{get; set;}

    public PageStyleHandler(){
        strStyleString = '';
    }

    //fetches the values from Font_Family custom settings for the picklist.
    public List<SelectOption> getFontNames (){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','None'));
        Map<String, Font_Family__c> objFontFamily = Font_Family__c.getAll();
        List<String> fontValues = new List<String>();
        fontValues.addAll(objFontFamily.keySet());
        fontValues.sort();

        for (String font : fontValues) {
            Font_Family__c fontName = objFontFamily.get(font);
            options.add(new SelectOption(fontName.Name, fontName.Name));
        }
        return options;
    }

    //fetches the values from Font_Weight custom settings for the picklist
    public List<SelectOption> getFontWeightOptions(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','None'));
        Map<String, Font_Weight__c> CSFontWeight = Font_Weight__c.getAll();
        List<String> fieldValues = new List<String>();
        fieldValues.addAll(CSFontWeight.keySet());
        fieldValues.sort();
        
        for (String fieldValue : fieldValues) {
            Font_Weight__c field = CSFontWeight.get(fieldValue);
            options.add(new SelectOption(field.Name, field.Name));
        }
        return options;
    }

    //Checks for the values selected by the user and generates a string for the Style Css.
    public void saveStyleCss(){
        strStyleString = '';
        if(strColor != null && !strColor.equals('')&& !strColor.equals('FFFFFF')){
            strStyleString += ' '+'Color'+': '+ strColor+';';
        }
        if(strFontFamily != null && !strFontFamily.equals('') && !strFontFamily.equals('None') ){
            strStyleString += ' '+'Font-Family'+': '+ strFontFamily+';';
        }
        if(strFontweight != null && !strFontweight.equals('') && !strFontweight.equals('None')){
            strStyleString += ' '+'Font-Weight'+': '+ strFontweight+';';
        }
        strStyleString = strStyleString.trim();
    }

    //Sets the value of all the fields when the page is loaded(Via actionFunction).
    public void parseStyleString(){
        if(strStyleString != null && !strStyleString.equals('')){
            list<String> lstStrStyle = strStyleString.split(';',-1);
            for(String srtstyle : lstStrStyle){
                srtstyle = srtstyle.trim();
                if(srtstyle.contains('Color')){
                   list<String> strTemp =  srtstyle.split(':',-1);
                   strColor = strTemp[1].trim();
                }
                if(srtstyle.contains('Font-Family')){
                   list<String> strTemp =  srtstyle.split(':',-1);
                   strFontFamily = strTemp[1].trim();
                }
                if(srtstyle.contains('Font-Weight')){
                   list<String> strTemp =  srtstyle.split(':',-1);
                   strFontweight = strTemp[1].trim();
                }
            }
        }
    }
}