# Step 1: Use official Node.js image
FROM node:18

# Step 2: Set the working directory
WORKDIR /usr/src/app

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the application source code
COPY . .

# Step 6: Expose the port for the React app
EXPOSE 3000

# Step 7: Start the app
CMD ["npm", "start"]

