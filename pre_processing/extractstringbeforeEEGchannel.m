function extractedString = extractstringbeforeEEGchannel(inputString)
    % Define the regular expression pattern to match characters before "eegchan"
    pattern = '^(.*?)eegchan';
    
    % Use the 'regexp' function to extract the matched substring
    tokens = regexp(inputString, pattern, 'tokens');
    
    % Check if there is a match and extract the string value
    if ~isempty(tokens)
        extractedString = tokens{1}{1};
    else
        % If no match is found, return an empty string or handle the error as needed
        extractedString = '';
        disp('No match found for "eegchan".');
    end
end
