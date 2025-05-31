- [ ] Add remap to select all content in a buffer.
- [ ] `conform prettier` does not work unless it is installed in the workspace. I would like it to work regardless of whether or not it is installed in the project.
- [ ] Consider using `echasnovski/mini.nvim` instead of `nvim-web-devicons`
- [ ] Customize render-markdown.nvim
    - [ ] Render vimwiki as markdown
- [ ] Persist undo history.


- [] comment-ts does not work properly in tsx files.
```md
  <Stack.Screen
    options={{
      headerTitle: workoutName,
      headerLeft: () => (
        <Pressable>
          <Feather name="chevron-left" size={20} color="black" />
        </Pressable>
      ),
      headerRight: () => (
        {/* <Pressable> */}                                       <---
        {/*   <Feather name="edit" size={18} color="black" /> */}  <--- It should have generated js comments
        {/* </Pressable> */}                                      <---
      ),
    }}
  />
```
