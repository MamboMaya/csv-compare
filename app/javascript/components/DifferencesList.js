import React from 'react';
import { List, ListItem, ListItemText } from '@material-ui/core';

export default function DifferencesList({ data }) {
  if (!data) return null;
  return(
    <List className="differences-list">
      {data.map((item, index) =>
        <ListItem key={`item-${index}`} alignItems="center" className="difference-item">
          <ListItemText
            primary={item}
          />
        </ListItem>
      )}
    </List>
  )
}
