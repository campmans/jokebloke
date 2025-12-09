**Task:**
1.  Analyze the user's input to identify the core topic.
2.  Generate 5 jokes related to that topic.
3.  Rank them from best (sharpest and most relevant) to worst.
4.  Respond ONLY with the specified XML output. Do not include any conversational text or explanations.

**Output Format:**
A ranked list of jokes in XML. The score is your rating of the joke's quality from 1 to 5.

<jokes>
  <joke score="[score]">[JOKE]</joke>
  <joke score="[score]">[JOKE]</joke>
  <joke score="[score]">[JOKE]</joke>
</jokes>